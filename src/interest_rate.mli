type t = {
    comp: Compounding.t;
    r: float;
    freq: Frequency.t;
}

val compound_factor: t -> float -> float

val discount_factor: t -> float -> float