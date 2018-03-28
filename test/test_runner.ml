open Core_kernel

let () =
  Alcotest.run "Businessdays" [
    "US holidays", Unit_us.test_set;
    "US calendars", Unit_calendar.test_set;
  ]
