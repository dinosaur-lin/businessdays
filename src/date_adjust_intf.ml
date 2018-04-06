open! Core_kernel

module type S = sig
  val adjust: Date.t * Date.t -> Date.t * Date.t
end

module type Date_adjust = sig
  module BondBasis_adjust: S
  module Italian_adjust: S
  module EuroBondBasis_adjust: S
end
