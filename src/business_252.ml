open! Core_kernel

let same_year dt1 dt2 =
  Date.year dt1 = Date.year dt2

let same_month dt1 dt2 =
  Date.year dt1 = Date.year dt2 && Date.month dt1 = Date.month dt2

module Make(Cal: Calendar_intf.S) = struct

  let name = "Business/252(" ^ Cal.name ^ ")"

  (** let day_count dt1 dt2 = *)

end
