open! Core_kernel

module Make (H: Holidayable_intf.S) :
sig
  type t = Date.Hash_set.t
  val create: unit -> t
  val is_holiday: t -> Date.t -> bool
end