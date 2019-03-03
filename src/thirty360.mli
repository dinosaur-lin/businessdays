open! Core_kernel

val bondbasis_adjust: Date.t * Date.t -> Date.t * Date.t

val italian_adjust: Date.t * Date.t -> Date.t * Date.t

val day_count: Date.t -> Date.t -> int

val year_frac: int -> float

