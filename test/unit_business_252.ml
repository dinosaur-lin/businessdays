open! Core_kernel
open Businessdays

module To_test = struct  
  let c y m d = Date.create_exn ~y:y ~m:m ~d:d

  (* FIXME, fix the test cases *)
  let test_business_252 () =    
    let test_dates = [ 
        c 2002 Feb 1,c 2002 Feb 4; 
        c 2002 Feb 4,c 2003 May 16;
    ]
    in 
    let module Dc = (val (Business_252.create Calendar.us_settlement): Day_counter_intf.S) in 
    List.map test_dates ~f:(fun (d1,d2) -> Dc.year_frac d1 d2)    
end

let test_business_252 () =
  Alcotest.(check (list (float 1e-5))) "test simple day counter" [0.0039682539683; 
    1.28571] (To_test.test_business_252 ())

let test_set = [
  "test_busienss_252", `Slow, test_business_252
]
