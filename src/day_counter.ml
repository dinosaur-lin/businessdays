open! Core_kernel 

type t_thirty360 =
  | BondBasis
  | EuroBondBasis
  | Italian

type t = 
  | Thirty360 of t_thirty360
  | Business252 of Calendar.t
  | Simple

let name dc = 
  match dc with 
  | Thirty360(BondBasis) -> "30/360 (Bond Basis)"
  | Thirty360(EuroBondBasis) -> "30E/360 (Eurobond Basis)"
  | Thirty360(Italian) -> "30/360 (Italian)"
  | Business252(c) -> "Business252(" ^ (Calendar.name c) ^ ")"
  | Simple -> "Simple"

let rec day_count dc dt1 dt2 = 
  match dc with 
  | Thirty360(sub_type) ->
  begin
    let (d1,d2) = match sub_type with 
    | BondBasis -> Thirty360.bondbasis_adjust (dt1,dt2)
    | EuroBondBasis -> (dt1,dt2)
    | Italian -> Thirty360.italian_adjust (dt1,dt2)
    in
    Thirty360.day_count d1 d2
  end
  | Business252(ct) -> 
    Business252.day_count ct dt1 dt2
  | Simple ->
    let dc1 = Thirty360(BondBasis) in  
    day_count dc1 dt1 dt2

let rec year_frac dc dt1 dt2 = 
  match dc with 
  | Thirty360(_) -> (float_of_int (day_count dc dt1 dt2)) /. 360.0
  | Business252(c) -> Business252.year_frac c dt1 dt2
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