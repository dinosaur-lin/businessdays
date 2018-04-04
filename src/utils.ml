open! Core_kernel

let extract_day_month_year_weekday dt =
  let d = Date.day dt in
  let m = Date.month dt in
  let y = Date.year dt in
  let w = Date.day_of_week dt in
  (d, m, y, w)

let is_day_in_nth_week n d =
  let start_d = (n - 1)*7+1 in
  let end_d = n * 7 in 
  d >= start_d && d <= end_d

let extract_day_month_year d = (
  Date.year d,
  Date.month d |> Month.to_int,
  Date.day d
)
