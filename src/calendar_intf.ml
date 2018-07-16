open! Core_kernel

module type S =
sig
  type t
  val name: string
  val create: unit -> t
end

module type N =
sig
  val name: string
end

(** calendar very static, so afford no state *)
module type Calendar = sig

  type t = { cache: Date.Hash_set.t;
             name: string; }

  val name: t -> string
  
  val month_days: int -> Month.t -> int
  (** [month_days year month] number of days for this month [month] in a year [year] *)

  val is_end_of_month: Date.t -> bool
  (** [is_end_of_month dt] determine whether a date [dt] is the end of month *)

  val is_holiday: t -> Date.t -> bool
  (** [is_holiday cal dt] determine whether a date [dt] is holiday or not in [cal] *)

  val adjust: t -> Date.t -> Business_day_convention.t -> Date.t
  (** [adjust cal dt bdc] Adjusts a non-business day [dt] to the appropriate nearest 
  business day with respect to the given convention [bdc], according to calendar [cal] *)

  val business_days_between: t -> Date.t -> Date.t -> int
  (** [business_days_between cal dt1 dt2] calculate the number of business days between two 
  days [dt1] and [dt2] *)

  module Make (H: Holidayable_intf.S)(N: N) : S with type t := t 
  module US_settlement : (S with type t := t)
  module US_libor_impact : (S with type t := t)
  module US_government_bond : (S with type t := t)

  val us_settlement: t

  val us_libor_impact: t

  val us_government_bond: t

end
