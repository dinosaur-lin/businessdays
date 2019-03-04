open! Core_kernel

type t =
| BondBasis
| EuroBondBasis
| Italian

val name: t -> string 

val day_count: t -> Date.t -> Date.t -> int

val year_frac: int -> float

