type t = {
    comp: Compounding.t;
    r: float;
    freq: float;
    time: float;
}

val compound_factor: t -> float -> float
