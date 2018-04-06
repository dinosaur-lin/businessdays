open! Core_kernel

module type S =
sig
  val name: string
  val day_count: Date.t -> Date.t -> int
  val year_frac: Date.t -> Date.t -> float
end
