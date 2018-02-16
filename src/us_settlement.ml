open! Core_kernel
open Us

type t = {
  name: string;
  cache: Date.Hash_set.t;
}

let init_cache_year t ~year ~is_holiday = 
  let begin_date = (Date.create_exn ~y:year ~m:Month.Jan ~d:1) in
  let y_days = if Date.is_leap_year year then 366 else 365 in
  List.range 1 y_days ~stop:`inclusive |>
  List.map ~f:(fun d -> Date.add_days begin_date d) |>
  List.iter ~f:(fun dt -> if is_holiday dt then Hash_set.add t.cache dt else ())  

let is_holiday_local dt =
  if is_washington_birthday dt ||
     is_memorial_day dt ||
     is_columbus_day dt ||
     is_labor_day dt ||
     is_veterans_day dt ||
     is_new_year_day dt ||
     is_martin_luther_king_birthday dt ||
     is_thanksgiving_day dt ||
     is_independence_day dt ||
     is_chrismas_day dt
  then true
  else false

let init_cache t start_year end_year = 
  for i = start_year to end_year do
    init_cache_year t ~year:i ~is_holiday:is_holiday_local
  done

let create () =
let t = { name = "US settlement"; cache = Date.Hash_set.create (); } in
init_cache t 1901 2199; t 

let is_holiday t dt =
  match (Hash_set.find t.cache (fun d -> dt = d)) with
  | Some _ -> true
  | None -> false

let is_business_day t dt =
  not (is_holiday t dt)

