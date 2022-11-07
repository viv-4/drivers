require "placeos-driver"

class Infosilem::MockCampus < PlaceOS::Driver
  # Discovery Information
  descriptive_name "Mock Infosilem Campus Driver"
  generic_name :Campus

  default_settings({
    response: <<-STRING
    [
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "01",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "00:00:00",
          "EndTime": "04:00:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dennis Tian",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "BLOCKOFF",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      },
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "05",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "03:00:00",
          "EndTime": "03:30:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dennis Tian",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "TEST EVENT 4",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      },
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "04",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "02:00:00",
          "EndTime": "02:30:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dummy Name",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "TEST EVENT 3",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      },
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "06",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "03:00:00",
          "EndTime": "03:30:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dummy Name",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "TEST EVENT 5",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      },
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "03",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "00:30:00",
          "EndTime": "01:00:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dummy Name",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "TEST EVENT 2",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      },
      {
          "EventID": "* GENERAL AND BLOCKOFF BOOKINGS",
          "EventType": "N",
          "ActivityID": "UTS",
          "ActivityType": "Z",
          "ReservationID": "02",
          "ReservationType": "BL",
          "OccurrenceDate": "2022-10-31",
          "OccurrenceDOW": "M",
          "StartTime": "00:15:00",
          "EndTime": "00:30:00",
          "SetupDuration": "00:00:00",
          "TeardownDuration": "00:00:00",
          "ReservationStartDate": "2022-10-31",
          "ReservationEndDate": "2022-10-31",
          "ReservationDOW": "M",
          "RecurrenceType": "0",
          "ReservationStatus": "1",
          "OccurrenceStatus": "0",
          "OccurrenceIsConflicting": "1",
          "RoomRequestStatus": "2",
          "Campus": "MCMST",
          "Building": "PGCLL",
          "Room": "B138",
          "NumberOfAttendees": "0",
          "RequestorUnit": "EMPLOYEE",
          "RequestorContactID": "Dummy Name",
          "EventFunctionalUnit": "UGRD",
          "EventSchedulingDataSet": "ACADEMIC_BOOKINGS",
          "ReservationDescription": "TEST EVENT 1",
          "EventManagedBy": "test.admin",
          "ActivityManagedBy": "test.admin",
          "ReservationManagedBy": "test.admin"
      }
    ]
    STRING
  })

  @response : String = "Error: No mock response configured in Settings"

  def on_load
    on_update
  end

  def on_update
    @response = setting?(String, :response) || "Error: No mock response configured in Settings"
  end

  def bookings?(building_id : String, room_id : String, start_date : String, end_date : String)
    @response
  end
end
