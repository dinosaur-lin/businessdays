open! Core_kernel

module type S =
sig
  type t
  val name: unit -> string
  val day_count: Date.t -> Date.t -> int
  val year_frac: Date.t -> Date.t -> float
end
