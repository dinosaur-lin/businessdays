open! Core_kernel
open Businessdays

module To_test = struct

  let c = Date.create_exn

  let test_thirty_360_bond_basis () =
    let dt1 = c 2006 Feb 28 in
    let dt2 = c 2006 Mar 3 in
    Thirty_360.US.day_count dt1 dt2 = 5

end

let test_thirty_360_bond_basis () =
  Alcotest.(check bool) "test thirty 360 bond basis" true (To_test.test_thirty_360_bond_basis ())

let test_set = [
  "test thirty 360 bond basis", `Slow, test_thirty_360_bond_basis;
]
