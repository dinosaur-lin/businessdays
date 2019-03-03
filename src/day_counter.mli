open! Core_kernel

type t_thirty360 =
  | BondBasis
  | EuroBondBasis
  | Italian

type t = 
  | Thirty360 of t_thirty360
  | Business252 of Calendar.t
  | Simple

val name: t -> string

val day_count: t -> Date.t -> Date.t -> int

val year_frac: t -> Date.t -> Date.t -> float