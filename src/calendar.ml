open! Core_kernel
open Business_day_convention

type t = { cache: Date.Hash_set.t;
           name: string; }

let days year month =
  match month with
  | Month.Jan -> 31
  | Month.Feb -> if Date.is_leap_year year then 29 else 28
  | Month.Mar -> 31
  | Month.Apr -> 30
  | Month.May -> 31
  | Month.Jun -> 30
  | Month.Jul -> 31
  | Month.Aug -> 31
  | Month.Sep -> 30
  | Month.Oct -> 31
  | Month.Nov -> 30
  | Month.Dec -> 31

let is_end_of_month dt =
  let m = Date.month dt in 
  let d = Date.day dt in
  match m with
  | Month.Jan -> d = 31
  | Month.Feb -> if Date.is_leap_year ~year:(Date.year dt) then d = 29 else d = 28
  | Month.Mar -> d = 31
  | Month.Apr -> d = 30
  | Month.May -> d = 31
  | Month.Jun -> d = 30
  | Month.Jul -> d = 31
  | Month.Aug -> d = 31
  | Month.Sep -> d = 30
  | Month.Oct -> d = 31
  | Month.Nov -> d = 30
  | Month.Dec -> d = 31

let init_cache_year t ~year ~is_holiday =
  let begin_date = (Date.create_exn year Jan 1) in
  let y_days = if Date.is_leap_year year then 366 else 365 in
  List.range 1 y_days ~stop:`inclusive |>
  List.map ~f:(fun d -> Date.add_days begin_date (d-1)) |>
  List.iter ~f:(fun dt -> if is_holiday dt then Hash_set.add t.cache dt else ())

let init_cache t start_year end_year is_holiday_local = 
  for i = start_year to end_year do
    init_cache_year t ~year:i ~is_holiday:is_holiday_local
  done

let is_holiday t dt =
  match (Hash_set.find t.cache (fun d -> dt = d)) with
  | Some _ -> true
  | None -> false

let name t = t.name

let rec adjust t dt c =
  if not (is_holiday t dt) then dt 
  else match c with
    | Following -> adjust t (Date.add_days dt 1) c 
    | Preceding -> adjust t (Date.add_days dt (-1)) c

let business_days_between t dt1 dt2 =
  let rec aux_b_days t dt1 dt2 =
    if dt1 = dt2 then 0
    else if is_holiday t dt1 then aux_b_days t (Date.add_days dt1 1) dt2
    else 1 + (aux_b_days t (Date.add_days dt1 1) dt2) in
  let c = Date.compare dt1 dt2 in
  if c = 0 then 0
  else if c < 0 then aux_b_days t dt1 dt2
  else -(aux_b_days t dt2 dt1)

module Make (H: Holidayable_intf.S)(N: Calendar_intf.N) =
struct
  type t

  let name = N.name

  let create () =
    let c = Date.Hash_set.create () in 
    let typ = { cache = c; name = N.name; } in
    init_cache typ 1901 2199 H.is_holiday;
    typ
end

(** need to assign name! *)
module US_settlement = Make(Us.Settlement)(struct let name = "US settlement" end)
module US_libor_impact = Make(Us.Libor_impact)(struct let name = "US with Libor impact" end)
module US_government_bond = Make(Us.Government_bond)(struct let name = "US government bond market" end)
