open! Core_kernel

module type S = 
sig
  type t 
  val create: unit -> t
end


module type Calendar = sig
  type t

  val is_holiday: t -> Date.t -> bool

  (** Adjusts a non-business day to the appropriate near business day with respect to the given convention. *)
  val adjust: t -> Date.t -> Business_day_convention.t -> Date.t

  module Make (H: Holidayable_intf.S) : S with type t := Date.Hash_set.t
  module US_settlement : S with type t := Date.Hash_set.t
  module US_libor_impact : S with type t := Date.Hash_set.t
  module US_government_bond : S with type t := Date.Hash_set.t

end with type t := Date.Hash_set.t
