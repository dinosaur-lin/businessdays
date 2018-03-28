open Core_kernel
open Businessdays

module To_test = struct

  let test_new_year_day () =
    Date.create_exn 2018 Jan 1 |> Us.is_new_year_day

  let test_martin_luther_king_birthday () =
    Date.create_exn 2018 Jan 15 |> Us.is_martin_luther_king_birthday

  let test_washington_birthday () =
    Date.create_exn 2018 Feb 19 |> Us.is_washington_birthday

  let test_memorial_day () =
    Date.create_exn 2018 May 28 |> Us.is_memorial_day

  let test_independence_day () =
    Date.create_exn 2018 Jul 4 |> Us.is_independence_day

  let test_labor_day () =
    Date.create_exn 2018 Sep 3 |> Us.is_labor_day

  let test_columbus_day () =
    Date.create_exn 2018 Oct 8 |> Us.is_columbus_day

  let test_veterans_day () =
    Date.create_exn 2018 Nov 12 |> Us.is_veterans_day

  let test_thanksgiving_day () =
    Date.create_exn 2018 Nov 22 |> Us.is_thanksgiving_day

  let test_christmas_day () =
    Date.create_exn 2018 Dec 25 |> Us.is_chrismas_day

  let test_good_friday () =
    Date.create_exn 2018 Mar 30 |> Us.is_good_friday    

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
  "test new year day", `Slow, test_new_year_day;
  "test martin luther king birthday", `Slow, test_martin_luther_king_birthday;
  "test washington birthday", `Slow, test_washington_birthday;
  "test memorial day", `Slow, test_memorial_day;
  "test independence day", `Slow, test_independence_day;
  "test labor day", `Slow, test_labor_day;
  "test columbus day", `Slow, test_columbus_day;
  "test veterans day", `Slow, test_veterans_day;
  "test thanksgiving day", `Slow, test_thanksgiving_day;
  "test christmas day", `Slow, test_christmas_day;
  "test good friday", `Slow, test_good_friday;
]
