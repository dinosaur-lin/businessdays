open! Core_kernel

type year_cache = (int, int) Hashtbl.t

type year_month_cache = (int, (Month.t,int) Hashtbl.t) Hashtbl.t

val day_count: Calendar.t -> Date.t -> Date.t -> int

val year_frac: Calendar.t -> Date.t -> Date.t -> float