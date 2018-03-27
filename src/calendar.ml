open! Core_kernel

module Make (H: Holidayable_intf.S) =
struct
  type t = Date.Hash_set.t

  let init_cache_year t ~year ~is_holiday = 
    let begin_date = (Date.create_exn ~y:year ~m:Month.Jan ~d:1) in
    let y_days = if Date.is_leap_year year then 366 else 365 in
    List.range 1 y_days ~stop:`inclusive |>
    List.map ~f:(fun d -> Date.add_days begin_date d) |>
    List.iter ~f:(fun dt -> if is_holiday dt then Hash_set.add t dt else ())  

  let init_cache t start_year end_year is_holiday_local = 
    for i = start_year to end_year do
      init_cache_year t ~year:i ~is_holiday:is_holiday_local
    done

  let create () =
    let t = Date.Hash_set.create () in 
    init_cache t 1901 2199 H.is_holiday;
    t
  
  let is_holiday t dt =
    match (Hash_set.find t (fun d -> dt = d)) with
    | Some _ -> true
    | None -> false
      
end

module US_settlement = Make(Us.Settlement)
module US_libor_impact = Make(Us.Libor_impact)
module US_government_bond = Make(Us.Government_bond)
