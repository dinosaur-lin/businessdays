open! Core_kernel

module type S = sig
  type t
  val create : unit -> t 
  val is_holiday: t -> Date.t -> bool
  val is_business_day: t -> Date.t -> bool
end
