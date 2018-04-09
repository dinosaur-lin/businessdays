open! Core_kernel

type year_cache = (int, int) Hashtbl.t

type year_month_cache = (int, (Month.t,int) Hashtbl.t) Hashtbl.t

val business_days_month: Calendar.t -> int -> Month.t -> int

val business_days_year: Calendar.t -> int -> int

val business_days_year_month_from_cache: (string, year_month_cache) Hashtbl.t -> Calendar.t -> int -> Month.t -> int

val business_days_year_from_cache: (string, year_cache) Hashtbl.t -> Calendar.t -> int -> int
