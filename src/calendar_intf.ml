open! Core_kernel

module type S = sig
  type t

  type calendar_type =
    |Weekends_only
    |US_Settlement
    |US_NYSE
    |US_GovernmentBond
    |US_NERC
    |US_LiborImpact
    |US_FederalReserve
    [@@deriving sexp, compare]

  (** calendar_type *)
  val create: calendar_type -> t

  val is_business_day: t -> Date.t -> bool

end
