open Core_kernel
open Businessdays
open Calendar

module To_test = struct

  let c = Date.create_exn

  let test_us_settlement () =    
    let holidays = [
      c 2017 Jan 2;
      c 2017 Jan 16;
      c 2017 May 29;
      c 2017 Jul 4;
      c 2017 Sep 4;
      c 2017 Nov 10;
      c 2017 Nov 23;
      c 2017 Dec 25;
    ] in
    let cal = US_settlement.create () in
    List.for_all holidays ~f:(fun dt -> is_holiday cal dt)

  let test_us_government_bond () =    
    let holidays = [
      c 2016 Jan 1;
      c 2016 Jan 18;
      c 2016 Mar 25;
      c 2016 May 30;
      c 2016 Jul 4;
      c 2016 Sep 5;
      c 2016 Nov 11;
      c 2016 Nov 24;
      c 2016 Dec 26;
    ] in
    let cal = US_government_bond.create () in
    List.for_all holidays ~f:(fun dt -> is_holiday cal dt)

end

let test_settlement () =
  Alcotest.(check bool) "test US settlement" true (To_test.test_us_settlement ())

let test_government_bond () =
  Alcotest.(check bool) "test US government bond" true (To_test.test_us_government_bond ())

let test_set = [
  "test US settlement", `Slow, test_settlement;
  "test US government bond", `Slow, test_government_bond;
]
