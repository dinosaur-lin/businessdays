open! Core_kernel

let name = "Simple"

let day_count =
  Thirty_360.BondBasis.day_count

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

let month_int dt =
  Date.month dt |> Month.to_int

let year_frac dt1 dt2 =
  let dd1 = Date.day dt1 in
  let dd2 = Date.day dt2 in 
  if dd1 = dd2 ||
     (* e.g., Aug 30 -> Feb 28 ?*)
     (dd1 > dd2 && is_end_of_month dt2) ||
     (* Feb 28 -> Aug 30 *)
     (dd1 < dd2 && is_end_of_month dt1)
  then (((Date.year dt2) - (Date.year dt1)) |> float_of_int) +.
       (((month_int dt2) - (month_int dt1)) |> float_of_int) /. 12.0
  else Thirty_360.BondBasis.year_frac dt1 dt2
