open! Core_kernel
open Businessdays

module To_test = struct  
  let c y m d = Date.create_exn ~y:y ~m:m ~d:d

  (* FIXME, fix the test cases *)
  let test_business_252_year_frac () =    
    let test_dates = [ 
        c 2002 Feb 1,c 2002 Feb 4; 
        c 2002 Feb 4,c 2003 May 16;
        c 2003 May 16,c 2003 Dec 17
    ]
    in 
    List.map test_dates ~f:(fun (d1,d2) -> Day_counter.year_frac (Business252(Calendar.us_settlement)) d1 d2)    

  let test_business_252_day_count () = 
    let test_dates = [ 
        c 2017 Oct 30,c 2019 Dec 1;
        c 2002 Feb 4,c 2003 May 16;
    ]
    in
    List.map test_dates ~f:(fun (d1,d2) -> Day_counter.day_count (Business252(Calendar.us_settlement)) d1 d2)    
end

let test_business_252_day_count () =
  Alcotest.(check (list int)) "test simple day counter" [523;323] (To_test.test_business_252_day_count ())

let test_business_252_year_frac () =
  Alcotest.(check (list (float 1e-5))) "test simple day counter" [0.003968253968253968; 
  1.2817460317460319;0.5833333333333334] (To_test.test_business_252_year_frac ())

let test_set = [
  "test_busienss_252_day_count", `Quick, test_business_252_day_count;
  "test_busienss_252_year_frac", `Quick, test_business_252_year_frac
]
