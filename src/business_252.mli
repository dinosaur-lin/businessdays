open! Core_kernel

val business_days_month: Calendar.t -> int -> Month.t -> int

val business_days_year: Calendar.t -> int -> int

val business_days_year_month_from_cache: (int, (Month.t,int) Hashtbl.t) Hashtbl.t -> Calendar.t -> int -> Month.t -> int

(* val business_days_year_from_cache: (int, int) Hashtbl.t -> Calendar.t -> int -> int *)
