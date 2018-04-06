open! Core_kernel

let day_count dt1 dt2 =
  360 * ((Date.year dt2) - (Date.year dt1)) 
  + 30 * ((Date.month dt2 |> Month.to_int) - (Date.month dt1 |> Month.to_int) - 1)
  + (max 0 (30 - (Date.day dt1)))
  + (min 30 (Date.day dt2))

module Make(A: Date_adjust_intf.S) = struct

  let day_count d1 d2 =
    let dd1,dd2 = A.adjust (d1,d2) in
    day_count dd1 dd2

  let year_frac d1 d2 =
    (float_of_int (day_count d1 d2)) /. 360.0

end

module BondBasis_adjust = Make(Date_adjust.BondBasis_adjust)
module Italian_adjust = Make(Date_adjust.Italian_adjust)
module EuroBondBasis_adjust = Make(Date_adjust.EuroBondBasis_adjust)

module BondBasis = struct
  include BondBasis_adjust
  let name = "30/360 (Bond Basis)"
end

module EuroBondBasis = struct
  include EuroBondBasis_adjust
  let name = "30E/360 (Eurobond Basis)"
end

module Italian = struct
  include Italian_adjust
  let name = "30/360 (Italian)"
end














