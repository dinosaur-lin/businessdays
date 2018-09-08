type t =
    | NoFrequency 
    | Once 
    | Annual
    | Semiannual 
    | EveryForthMonth
    | Quanterly
    | Bimonthly
    | Monthly
    | EveryForthWeek
    | Biweekly
    | Weekly
    | Daily
    | OtherFrequency

let to_float = function
    | NoFrequency -> -1.0
    | Once -> 0.0
    | Annual -> 1.0
    | Semiannual -> 2.0
    | EveryForthMonth -> 3.0 
    | Quanterly -> 4.0
    | Bimonthly -> 6.0
    | Monthly -> 12.0
    | EveryForthWeek -> 13.0
    | Biweekly -> 26.0
    | Weekly -> 52.0
    | Daily -> 365.0
    | OtherFrequency -> 999.0