open! Core_kernel
open Businessdays

module To_test = struct

  let c = Date.create_exn

  let test_data = [
      (** ISDA - Example 1: End dates do not involve the last day of February *)
      c 2006 Aug 20,c 2007 Feb 20;
      c 2007 Feb 20,c 2007 Aug 20;
      c 2007 Aug 20,c 2008 Feb 20;
      c 2008 Feb 20,c 2008 Aug 20;
      c 2008 Aug 20,c 2009 Feb 20;
      c 2009 Feb 20,c 2009 Aug 20;

      (** ISDA - Example 2: End dates include some end-February dates *)
      c 2006 Aug 31,c 2007 Feb 28;
      c 2007 Feb 28,c 2007 Aug 31;
      c 2007 Aug 31,c 2008 Feb 29;
      c 2008 Feb 29,c 2008 Aug 31;
      c 2008 Aug 31,c 2009 Feb 28;
      c 2009 Feb 28,c 2009 Aug 31;

      (** ISDA - Example 3: Miscellaneous calculations *)
      c 2006 Jan 31,c 2006 Feb 28;
      c 2006 Jan 30,c 2006 Feb 28;
      c 2006 Feb 28,c 2006 Mar 3;
    ]

  let test_thirty_360_bond_basis () =
    List.map test_data (fun (dt1,dt2) -> Thirty_360.US.day_count dt1 dt2)

  let test_thirty_360_euro_bond_basis () =
    List.map test_data (fun (dt1,dt2) -> Thirty_360.EU.day_count dt1 dt2)
end

let test_thirty_360_bond_basis () =
  Alcotest.(check (list int)) "test thirty 360 bond basis" [180; 180; 180; 180; 180; 180;
                                                            178; 183; 179; 182; 178; 183;
                                                            28; 28; 5] (To_test.test_thirty_360_bond_basis ())

let test_thirty_360_euro_bond_basis () =
  Alcotest.(check (list int)) "test thirty 360 Euro bond basis" [180; 180; 180; 180; 180; 180;
                                                                 178; 182; 179; 181; 178; 182;
                                                                 28; 28; 5] (To_test.test_thirty_360_euro_bond_basis ())

let test_set = [
  "test thirty 360 bond basis", `Slow, test_thirty_360_bond_basis;
  "test thirty 360 euro bond basis", `Slow, test_thirty_360_euro_bond_basis;
]
