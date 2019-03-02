open! Core_kernel 

type t_thirty360 =
  | BondBasis
  | EuroBondBasis
  | Italian

type t = 
  | Thirty360 of t_thirty360
  | Simple

let name dc = 
  match dc with 
  | Thirty360(BondBasis) -> "30/360 (Bond Basis)"
  | Thirty360(EuroBondBasis) -> "30E/360 (Eurobond Basis)"
  | Thirty360(Italian) -> "30/360 (Italian)"
  | Simple -> "Simple"

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

let thirty360_day_count dt1 dt2 =
  360 * ((Date.year dt2) - (Date.year dt1)) 
  + 30 * ((Date.month dt2 |> Month.to_int) - (Date.month dt1 |> Month.to_int) - 1)
  + (max 0 (30 - (Date.day dt1)))
  + (min 30 (Date.day dt2))

let rec day_count dc dt1 dt2 = 
  match dc with 
  | Thirty360(sub_type) ->
  begin
    let (d1,d2) = match sub_type with 
    | BondBasis -> bondbasis_adjust (dt1,dt2)
    | EuroBondBasis -> (dt1,dt2)
    | Italian -> italian_adjust (dt1,dt2)
    in
    thirty360_day_count d1 d2
  end  
  | Simple ->
    let dc1 = Thirty360(BondBasis) in  
    day_count dc1 dt1 dt2

let rec year_frac dc dt1 dt2 = 
  match dc with 
  | Thirty360(_) -> (float_of_int (day_count dc dt1 dt2)) /. 360.0
  | Simple -> 
    let dd1 = Date.day dt1 in
    let dd2 = Date.day dt2 in 
    if dd1 = dd2 ||
     (* e.g., Aug 30 -> Feb 28 ?*)
       (dd1 > dd2 && Calendar.is_end_of_month dt2) ||
       (* Feb 28 -> Aug 30 *)
       (dd1 < dd2 && Calendar.is_end_of_month dt1)
    then (((Date.year dt2) - (Date.year dt1)) |> float_of_int) +.
         (((Utils.month_int dt2) - (Utils.month_int dt1)) |> float_of_int) /. 12.0
    else let dc1 = Thirty360(BondBasis) in year_frac dc1 dt1 dt2