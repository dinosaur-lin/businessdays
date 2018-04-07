open! Core_kernel

let name = "Simple"

let day_count =
  Thirty_360.BondBasis.day_count

let month_int dt =
  Date.month dt |> Month.to_int

let year_frac dt1 dt2 =
  let dd1 = Date.day dt1 in
  let dd2 = Date.day dt2 in 
  if dd1 = dd2 ||
     (* e.g., Aug 30 -> Feb 28 ?*)
     (dd1 > dd2 && Calendar.is_end_of_month dt2) ||
     (* Feb 28 -> Aug 30 *)
     (dd1 < dd2 && Calendar.is_end_of_month dt1)
  then (((Date.year dt2) - (Date.year dt1)) |> float_of_int) +.
       (((month_int dt2) - (month_int dt1)) |> float_of_int) /. 12.0
  else Thirty_360.BondBasis.year_frac dt1 dt2
