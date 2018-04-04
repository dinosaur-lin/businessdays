open! Core_kernel

type convention =
  | USA
  | BondBasis
  | European
  | EurobondBasis
  | Italian

let day_count dt1 dt2 =
  360 * ((Date.year dt2) - (Date.year dt1)) 
  + 30 * ((Date.month dt2 |> Month.to_int) - (Date.month dt1 |> Month.to_int) - 1)
  + (max 0 (30 - (Date.day dt1)))
  + (min 30 (Date.day dt2))

module Us = struct
  let adjust (d1,d2) =
    let (yy1,mm1,dd1) = Utils.extract_day_month_year d1 in
    let (yy2,mm2,dd2) = Utils.extract_day_month_year d2 in
    let (ddd2,mmm2) = if dd2 = 31 && dd1 < 30 then (1, mm2+1) else (dd2, mm2) in
    d1,(Date.create_exn ~y:yy2 ~m:(Month.of_int_exn mmm2) ~d:ddd2)
end

module It = struct
  let adjust (d1,d2) =
    let modify_day m d = if m = 2 && d > 27 then 30 else d in
    let (yy1,mm1,dd1) = Utils.extract_day_month_year d1 in
    let (yy2,mm2,dd2) = Utils.extract_day_month_year d2 in
    let ddd1 = modify_day mm1 dd1 in
    let ddd2 = modify_day mm2 dd2 in
    (Date.create_exn ~y:yy1 ~m:(Month.of_int_exn mm1) ~d:ddd1),(Date.create_exn ~y:yy2 ~m:(Month.of_int_exn mm2) ~d:ddd2)
end

module Eu = struct
  let adjust (d1,d2) = (d1,d2)
end

module Make(A: Date_adjust_intf.S) = struct

  let day_count d1 d2 =
    let dd1,dd2 = A.adjust (d1,d2) in
    day_count dd1 dd2

  let year_frac d1 d2 =
    (float_of_int (day_count d1 d2)) /. 360.0

end
