open! Core_kernel

type t = 
  | Thirty360 of Thirty_360.t
  | Business252 of Calendar.t
  | Simple

val name: t -> string

val day_count: t -> Date.t -> Date.t -> int

val year_frac: t -> Date.t -> Date.t -> float