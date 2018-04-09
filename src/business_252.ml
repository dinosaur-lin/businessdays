open! Core_kernel

let same_year dt1 dt2 =
  Date.year dt1 = Date.year dt2

let same_month dt1 dt2 =
  Date.year dt1 = Date.year dt2 && Date.month dt1 = Date.month dt2

let business_days_month cal year month =
  let dt1 = Date.create_exn year month 1 in
  let dt2 = Date.add_days dt1 (Calendar.days year month) in
  Calendar.business_days_between cal dt1 dt2

let business_days_year cal year =
  List.range 1 12 ~stop:`inclusive |>
  List.map ~f:(fun i -> Month.of_int_exn i) |>
  List.map ~f:(fun m -> business_days_month cal year m) |>
  List.reduce_exn ~f:(fun a b -> a + b)

let business_days_year_month_from_cache cache cal year month =
  let iner_cache = Hashtbl.find_or_add cache year ~default:(fun _ -> Hashtbl.create (module Month) ()) in
  Hashtbl.find_or_add iner_cache month ~default:(fun _ -> business_days_month cal year month)


module Make(Cal: Calendar_intf.S) = struct

  let name = "Business/252(" ^ Cal.name ^ ")"

  (** let day_count dt1 dt2 = *)

end
