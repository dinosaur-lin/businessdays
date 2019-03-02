open! Core_kernel

val extract_day_month_year_weekday: Date.t -> (int * Month.t * int * Day_of_week.t)

val extract_day_month_year: Date.t -> (int * int * int)

val is_day_in_nth_week: int -> int -> bool

val month_int: Date.t -> int