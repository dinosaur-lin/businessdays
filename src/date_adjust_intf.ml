open! Core_kernel

module type S = sig
  val adjust: Date.t * Date.t -> Date.t * Date.t
end
