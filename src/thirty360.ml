open! Core_kernel

let bondbasis_adjust (d1,d2) =
  let (_,_,dd1) = Utils.extract_day_month_year d1 in
  let (yy2,mm2,dd2) = Utils.extract_day_month_year d2 in
  let (ddd2,mmm2) = if dd2 = 31 && dd1 < 30 then (1, mm2+1) else (dd2, mm2) in
  d1,(Date.create_exn ~y:yy2 ~m:(Month.of_int_exn mmm2) ~d:ddd2)

let italian_adjust (d1,d2) =
  let modify_day m d = if m = 2 && d > 27 then 30 else d in
  let (yy1,mm1,dd1) = Utils.extract_day_month_year d1 in
  let (yy2,mm2,dd2) = Utils.extract_day_month_year d2 in
  let ddd1 = modify_day mm1 dd1 in
  let ddd2 = modify_day mm2 dd2 in
  (Date.create_exn ~y:yy1 ~m:(Month.of_int_exn mm1) ~d:ddd1),(Date.create_exn ~y:yy2 ~m:(Month.of_int_exn mm2) ~d:ddd2)

let day_count dt1 dt2 =
  360 * ((Date.year dt2) - (Date.year dt1)) 
  + 30 * ((Date.month dt2 |> Month.to_int) - (Date.month dt1 |> Month.to_int) - 1)
  + (max 0 (30 - (Date.day dt1)))
  + (min 30 (Date.day dt2))
