open! Core_kernel

type year_cache = (int, int) Hashtbl.t

type year_month_cache = (int, (Month.t,int) Hashtbl.t) Hashtbl.t

let year_cache = Hashtbl.create (module String)

let year_month_cache = Hashtbl.create (module String)

let same_year dt1 dt2 =
  Date.year dt1 = Date.year dt2

let same_month dt1 dt2 =
  Date.year dt1 = Date.year dt2 && Date.month dt1 = Date.month dt2

let business_days_month cal year month =
  let dt1 = Date.create_exn ~y:year ~m:month ~d:1 in
  let dt2 = Date.add_days dt1 (Calendar.month_days year month) in
  Calendar.business_days_between cal dt1 dt2

let business_days_year cal year =
  List.range 1 12 ~stop:`inclusive |>
  List.map ~f:(fun i -> Month.of_int_exn i) |>
  List.map ~f:(fun m -> business_days_month cal year m) |>
  List.reduce_exn ~f:(fun a b -> a + b)

let business_days_year_month_from_cache cache cal year month =
  let outer_cache = Hashtbl.find_or_add cache (Calendar.name cal) ~default:(fun _ -> Hashtbl.create (module Int)) in
  let inner_cache = Hashtbl.find_or_add outer_cache year ~default:(fun _ -> Hashtbl.create (module Month)) in
  Hashtbl.find_or_add inner_cache month ~default:(fun _ -> business_days_month cal year month)

let business_days_year_from_cache cache cal year =
  let inner_cache = Hashtbl.find_or_add cache (Calendar.name cal) ~default:(fun _ -> Hashtbl.create (module Int)) in
  Hashtbl.find_or_add inner_cache year ~default:(fun _ -> business_days_year cal year)

let begin_next_month dt =
  let y = Date.year dt in
  let m = Date.month dt in
  Date.add_days (Date.create_exn ~y:y ~m:m ~d:1) (Calendar.month_days y m)

let first_month_days cal_type dt1 =
  let next_month_begin = begin_next_month dt1 in
  Calendar.business_days_between cal_type dt1 (Date.add_days next_month_begin (-1))

let last_month_days cal_type dt2 =
  let end_last_month = Date.add_days (Date.create_exn ~y:(Date.year dt2) ~m:(Date.month dt2) ~d:1) (-1) in
  Calendar.business_days_between cal_type end_last_month dt2

let month_days cal_type m1 m2 y =
  let months = List.range ~stop:`inclusive m1 m2 in
  List.map months ~f:(fun m -> business_days_year_month_from_cache year_month_cache cal_type y (Month.of_int_exn m)) |>
  List.fold_left ~init:0 ~f:(fun a b -> a + b)

let intermediate_month_days cal_type dt1 dt2 =
  let m1 = Date.month dt1 |> Month.to_int in
  let m2 = Date.month dt2 |> Month.to_int in
  let y = Date.year dt1 in
  month_days cal_type (m1 + 1) (m2 - 1) y

let intermediate_years_days cal_type dt1 dt2 =
  let y1 = (Date.year dt1) in
  let y2 = (Date.year dt2) in
  List.range y1 y2 ~start:`exclusive ~stop:`exclusive |>
  List.map ~f:(fun y -> business_days_year_from_cache year_cache cal_type y) |>
  List.fold_left ~init:0 ~f:(fun a b -> a + b)

let remaining_month_days cal_type dt1 =
  let m1 = Date.month dt1 |> Month.to_int in
  let y = Date.year dt1 in
  month_days cal_type (m1 + 1) 12 y

let begin_month_days cal_type dt2 =
  let m2 = (Date.month dt2 |> Month.to_int) in
  let y = Date.year dt2 in
  month_days cal_type 1 (m2-1) y

let create c =
  let module DC: Day_counter_intf.S  = struct 
    let name =  "Business/252(" ^ (Calendar.name c) ^ ")"
    
    let day_count dt1 dt2 =
      if same_month dt1 dt2 || Date.(dt1 > dt2) then
        Calendar.business_days_between c dt1 dt2
      else if same_year dt1 dt2 then 
        let first = first_month_days c dt1 in
        let inter = intermediate_month_days c dt1 dt2 in
        let last = last_month_days c dt2 in
        first + inter + last
      else let first_month = first_month_days c dt1 in
        let remaining_month = remaining_month_days c dt1 in
        let inter_y = intermediate_years_days c dt1 dt2 in
        let begin_month = begin_month_days c dt2 in
        let last_month = last_month_days c dt2 in
        first_month + remaining_month + inter_y + begin_month + last_month  

    let year_frac dt1 dt2 =
      float_of_int(day_count dt1 dt2) /. 252.0      
  end
  in 
  (module DC: Day_counter_intf.S)