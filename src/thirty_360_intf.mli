open! Core_kernel

module type S =
sig
  val day_count: Date.t -> Date.t -> int
  val year_frac: Date.t -> Date.t -> float
end

module type Thirty_360 = sig
  module US: S
  module EU: S
  module IT: S
end
