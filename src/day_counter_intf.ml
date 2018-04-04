open! Core_kernel

module type S =
sig
  val day_count: Date.t -> Date.t -> int
  val year_frac: Date.t -> Date.t -> float
end
