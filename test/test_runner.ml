let () =
  Alcotest.run "Businessdays" [
    "US holidays", Unit_us_holidays.test_set;
    "US calendars", Unit_calendar.test_set;
    "Day counter thirty 360", Unit_thirty_360.test_set;
    "Simple day counter", Unit_simple_day_counter.test_set
  ]
