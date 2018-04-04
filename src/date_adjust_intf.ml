open! Core_kernel

module type S = sig
  val adjust: Date.t * Date.t -> Date.t * Date.t
end

module type Date_adjust = sig
  module US: S
  module IT: S
  module EU: S
end
