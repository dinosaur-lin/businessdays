open! Core_kernel

val extract_day_month_year_weekday: Date.t -> (int * Month.t * int * Day_of_week.t)

val is_day_in_nth_week: int -> int -> bool

