type t = {
    comp: Compounding.t;
    r: float;
    freq: Frequency.t;
    time: float;
}

val compound_factor: t -> float -> float
