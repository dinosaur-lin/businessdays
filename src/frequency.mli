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

val to_float: t -> float