require "placeos-driver"
require "placeos-driver/proxy/remote_driver"
require "placeos-core-client"
require "redis_service_manager"

# Reports whether the driver processes on every core node in the cluster are
# running.
#
# Core nodes are discovered from the service registration that
# `Proxy::RemoteDriver` already uses to route module requests, so no API key or
# request to an external PlaceOS instance is required. Each node is then asked
# about its own driver processes over core's internal API (`/api/core/v1`), the
# same data rest-api aggregates for its `/cluster` routes.
class Place::DriverHealth < PlaceOS::Driver
  descriptive_name "PlaceOS Driver Health"
  generic_name :DriverHealth
  description %(Checks that the driver processes on every core node in the cluster are running, exposing a running state (1 or 0) per driver for backoffice and InfluxDB)

  default_settings({
    # how often to check the cluster, set to 0 to only check on request
    check_every_minutes: 5,

    # optionally check a fixed set of core nodes, `node id => core URI`.
    # the cluster is discovered when this is empty, which is what you want
    # in a normal deployment
    core_nodes: {} of String => String,
  })

  # attempts made against a core node before it's considered unreachable.
  # the client default of 10 (with a 40 second max interval) would stall the
  # check for minutes against a node that is down
  CORE_RETRIES = 2

  # driver executables are named `<source path>_<short commit>_<arch>` by the
  # build service, i.e. `drivers_place_bookings_4894a36_arm64`
  EXECUTABLE_NAME = /\A(?<driver>.+)_(?<commit>[0-9a-f]{7})_(?<arch>[a-z0-9]+)\z/

  struct DriverState
    include JSON::Serializable

    # `<hostname>.<driver>`, unique across the cluster
    getter name : String

    # the core node the driver process is on, i.e. `core-0`
    getter hostname : String

    # the driver source path, i.e. `drivers_place_bookings`
    getter driver : String

    # the short commit hash the driver was built from, i.e. `4894a36`
    getter commit : String

    # 1 when the driver process was using memory when we asked, otherwise 0.
    # numeric rather than boolean so InfluxDB can aggregate it (mean, sum)
    getter running : Int32

    # when the running state was checked, unix seconds
    getter timestamp : Int64

    def initialize(@hostname, executable : String, @running, @timestamp)
      if match = EXECUTABLE_NAME.match(executable)
        @driver = match["driver"]
        @commit = match["commit"]
      else
        @driver = executable
        @commit = ""
      end
      @name = "#{@hostname}.#{@driver}"
    end
  end

  @check_every : Time::Span = 5.minutes
  @core_nodes : Hash(String, URI) = {} of String => URI
  @discovery : Clustering::Discovery? = nil

  def on_load
    on_update
  end

  def on_update
    @check_every = (setting?(Int32, :check_every_minutes) || 5).minutes
    @core_nodes = (setting?(Hash(String, String), :core_nodes) || {} of String => String)
      .transform_values { |uri| URI.parse uri }

    schedule.clear
    return unless @check_every > Time::Span.zero

    # let the cluster settle before the first check, drivers are still launching
    # for a while after a core node starts
    schedule.in(30.seconds) { check_drivers }
    schedule.every(@check_every) { check_drivers }
  end

  # the core nodes that make up the cluster, `node id => core URI`
  def cluster_nodes : Hash(String, String)
    core_nodes.transform_values(&.to_s)
  end

  # checks every driver process on every core node in the cluster
  def check_drivers : Array(DriverState)
    clusters = [] of NamedTuple(id: String, name: String)
    unreachable = [] of String
    drivers = [] of DriverState

    core_nodes.each do |id, uri|
      begin
        hostname, states = check_node uri
        clusters << {id: id, name: hostname}
        drivers.concat states
      rescue error
        logger.warn(exception: error) { "failed to query core node #{id} on #{uri}" }
        unreachable << id
      end
    end

    drivers.sort_by!(&.name)
    not_running = drivers.select(&.running.zero?).map(&.name)

    self[:clusters] = clusters
    self[:unreachable_clusters] = unreachable
    # exposed as InfluxDB tags so each driver process is its own series
    self[:drivers] = {
      value:       drivers,
      ts_hint:     "complex",
      ts_tag_keys: ["name", "hostname"],
    }
    self[:driver_count] = drivers.size
    self[:running_count] = drivers.size - not_running.size
    self[:not_running] = not_running
    self[:last_checked] = Time.utc.to_unix

    drivers
  end

  # returns the nodes hostname and the state of the drivers running on it
  protected def check_node(uri : URI) : Tuple(String, Array(DriverState))
    PlaceOS::Core::Client.client(uri, retries: CORE_RETRIES) do |client|
      # the hostname of the pod, i.e. `core-0`
      hostname = client.core_load.local.hostname

      # a mapping of driver => the modules that driver is running
      states = client.loaded.local.keys.map do |driver|
        # no status or no memory in use means the process isn't running
        memory = client.driver_status(driver).local.try(&.memory_usage) || 0_i64
        DriverState.new(hostname, driver, memory.zero? ? 0 : 1, Time.utc.to_unix)
      end

      {hostname, states}
    end
  end

  # the configured nodes, otherwise the nodes registered in the cluster
  protected def core_nodes : Hash(String, URI)
    nodes = @core_nodes
    return nodes unless nodes.empty?
    discovery.node_hash
  end

  # reads the core service registration, the same one `Proxy::RemoteDriver` uses
  # to work out which node is running a module. we only ever read from it, this
  # process is not a member of the cluster
  protected def discovery : Clustering::Discovery
    @discovery ||= Clustering::Discovery.new(
      RedisServiceManager.new(
        service: PlaceOS::Driver::Proxy::RemoteDriver::CORE_NAMESPACE,
        redis: PlaceOS::Driver::RedisStorage.shared_redis_client,
        lock: PlaceOS::Driver::RedisStorage.redis_lock
      )
    )
  end
end
