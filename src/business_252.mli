open! Core_kernel

type year_cache = (int, int) Hashtbl.t

type year_month_cache = (int, (Month.t,int) Hashtbl.t) Hashtbl.t

val create: Calendar.t -> (module Day_counter_intf.S)