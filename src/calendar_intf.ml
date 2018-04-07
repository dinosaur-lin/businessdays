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

module type Calendar = sig
  type t = { cache: Date.Hash_set.t;
             name: string; }

  val is_holiday: t -> Date.t -> bool

  (** Adjusts a non-business day to the appropriate near business day with respect to the given convention. *)
  val adjust: t -> Date.t -> Business_day_convention.t -> Date.t

  val business_days_between: t -> Date.t -> Date.t -> int

  module Make (H: Holidayable_intf.S)(N: N) : S with type t := t 
  module US_settlement : (S with type t := t)
  module US_libor_impact : (S with type t := t)
  module US_government_bond : (S with type t := t)

end
