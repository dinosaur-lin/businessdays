open Core_kernel
open Businessdays

module To_test = struct

  let test_new_year_day () =
    Date.create_exn ~y:2018 ~m:Jan ~d:1 |> Us_holidays.is_new_year_day

  let test_martin_luther_king_birthday () =
    Date.create_exn ~y:2018 ~m:Jan ~d:15 |> Us_holidays.is_martin_luther_king_birthday

  let test_washington_birthday () =
    Date.create_exn ~y:2018 ~m:Feb ~d:19 |> Us_holidays.is_washington_birthday

  let test_memorial_day () =
    Date.create_exn ~y:2018 ~m:May ~d:28 |> Us_holidays.is_memorial_day

  let test_independence_day () =
    Date.create_exn ~y:2018 ~m:Jul ~d:4 |> Us_holidays.is_independence_day

  let test_labor_day () =
    Date.create_exn ~y:2018 ~m:Sep ~d:3 |> Us_holidays.is_labor_day

  let test_columbus_day () =
    Date.create_exn ~y:2018 ~m:Oct ~d:8 |> Us_holidays.is_columbus_day

  let test_veterans_day () =
    Date.create_exn ~y:2018 ~m:Nov ~d:12 |> Us_holidays.is_veterans_day

  let test_thanksgiving_day () =
    Date.create_exn ~y:2018 ~m:Nov ~d:22 |> Us_holidays.is_thanksgiving_day

  let test_christmas_day () =
    Date.create_exn ~y:2018 ~m:Dec ~d:25 |> Us_holidays.is_chrismas_day

  let test_good_friday () =
    Date.create_exn ~y:2018 ~m:Mar ~d:30 |> Us_holidays.is_good_friday    

end

let test_new_year_day () =
  Alcotest.(check bool) "test new year day" true (To_test.test_new_year_day ())

let test_martin_luther_king_birthday () =
  Alcotest.(check bool) "test martin luther king birthday" true (To_test.test_martin_luther_king_birthday ())

let test_washington_birthday () =
  Alcotest.(check bool) "test washington birthday" true (To_test.test_washington_birthday ())

let test_memorial_day () =
  Alcotest.(check bool) "test memorial day" true (To_test.test_memorial_day ())

let test_independence_day () =
  Alcotest.(check bool) "test independence day" true (To_test.test_independence_day ())

let test_labor_day () =
  Alcotest.(check bool) "test labor day" true (To_test.test_labor_day ())

let test_columbus_day () =
  Alcotest.(check bool) "test columbus day" true (To_test.test_columbus_day ())

let test_veterans_day () =
  Alcotest.(check bool) "test veterans day" true (To_test.test_veterans_day ())

let test_thanksgiving_day () =
  Alcotest.(check bool) "test thanksgiving  day" true (To_test.test_thanksgiving_day ())

let test_christmas_day () =
  Alcotest.(check bool) "test christmas day" true (To_test.test_christmas_day ())

let test_good_friday () =
  Alcotest.(check bool) "test good friday" true (To_test.test_good_friday ())  

let test_set = [
  "test new year day", `Quick, test_new_year_day;
  "test martin luther king birthday", `Quick, test_martin_luther_king_birthday;
  "test washington birthday", `Quick, test_washington_birthday;
  "test memorial day", `Quick, test_memorial_day;
  "test independence day", `Quick, test_independence_day;
  "test labor day", `Quick, test_labor_day;
  "test columbus day", `Quick, test_columbus_day;
  "test veterans day", `Quick, test_veterans_day;
  "test thanksgiving day", `Quick, test_thanksgiving_day;
  "test christmas day", `Quick, test_christmas_day;
  "test good friday", `Quick, test_good_friday;
]
