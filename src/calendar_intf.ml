open! Core_kernel

module type Calendar_maker =
sig  
  type t
  val create: unit -> t
end

module type Calendar = sig

  type t = { cache: Date.Hash_set.t;
             name: string; }

  val name: t -> string
  (** [name] return the name of the calendar *)
  
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

  module US_settlement : (Calendar_maker with type t := t)
  module US_libor_impact : (Calendar_maker with type t := t)
  module US_government_bond : (Calendar_maker with type t := t)

  val us_settlement: t
  val us_libor_impact: t
  val us_government_bond: t

end
