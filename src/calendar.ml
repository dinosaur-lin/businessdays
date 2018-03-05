open! Core_kernel

type calendar_type =
  |Weekends_only
  |US_Settlement
  |US_NYSE
  |US_GovernmentBond
  |US_NERC
  |US_LiborImpact
  |US_FederalReserve
[@@deriving sexp, compare]

type t = {
  cal_type: calendar_type;
  cache: Date.Hash_set.t;
}

let cal_holiday_fun_tbl = Hashtbl.Poly.of_alist_exn [
    (Weekends_only, Date.is_weekend);
    (US_Settlement, Us.Settlement.is_holiday);
    (US_LiborImpact, Us.Libor_impact.is_holiday);
    (US_GovernmentBond, Us.Government_bond.is_holiday)
  ]

let init_cache_year t ~year ~is_holiday = 
  let begin_date = (Date.create_exn ~y:year ~m:Month.Jan ~d:1) in
  let y_days = if Date.is_leap_year year then 366 else 365 in
  List.range 1 y_days ~stop:`inclusive |>
  List.map ~f:(fun d -> Date.add_days begin_date d) |>
  List.iter ~f:(fun dt -> if is_holiday dt then Hash_set.add t.cache dt else ())  

let init_cache t start_year end_year is_holiday_local = 
  for i = start_year to end_year do
    init_cache_year t ~year:i ~is_holiday:is_holiday_local
  done

let create cal_typ =
  let t = {
    cache = Date.Hash_set.create ();
    cal_type = cal_typ;
  } in
  let holiday_fun = Hashtbl.find_exn cal_holiday_fun_tbl cal_typ in
  init_cache t 1901 2199 holiday_fun;
  t

let is_holiday t dt =
  match (Hash_set.find t.cache (fun d -> dt = d)) with
  | Some _ -> true
  | None -> false

let is_business_day t dt =
  not (is_holiday t dt)

let rec business_days_between t dt1 dt2 =
  if dt1 = dt2 then 0
  else if is_business_day t dt1 then 1 + (business_days_between t (Date.add_days dt1 1) dt2)
  else business_days_between t (Date.add_days dt1 1) dt2

(** brute force of table look up doesn't work! since it will takes too much memory! *)
(** table look up to return business days takes so much memory!: 365*300*365*300 *)
(** caurc grain look up: table look up inside a day *)
