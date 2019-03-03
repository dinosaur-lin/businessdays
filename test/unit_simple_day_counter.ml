open! Core_kernel
open Businessdays

module To_test = struct
  
  let test_simple_day_counter () =    
    let periods = [ 3; 6; 12 ] (* months *) in 
    let first = Date.create_exn ~y:2002 ~m:Jan ~d:1 in 
    let ends = List.map periods ~f:(fun p -> Date.add_months first p) in
    let dc = Day_counter.Simple in 
    List.map ends ~f:(fun e -> Day_counter.year_frac dc first e)
end

let test_simple_day_counter () =
  Alcotest.(check (list (float 1e-12))) "test simple day counter" [0.25; 0.5; 1.0] (To_test.test_simple_day_counter ())

let test_set = [
  "test_simple_day_counter", `Quick, test_simple_day_counter
]
