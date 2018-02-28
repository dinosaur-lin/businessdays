open! Core_kernel

module type S = sig
  val is_holiday: Date.t -> bool
end
