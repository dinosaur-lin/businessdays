type t = {
    comp: Compounding.t;
    r: float;
    freq: float;
    time: float;
}

let simple t time = 1.0 +. t.r *. time

let compounded t time = ((1.0 +. t.r) /. t.freq) ** (t.freq *. time)

let compound_factor t time = 
    match t.comp with
    | Compounding.Simple -> simple t time
    | Compounding.Compounded -> compounded t time
    | Compounding.Continuous -> exp (t.r *. time)
    | Compounding.SimpleThenCompounted -> if time <= 1.0 /. t.freq then simple t time else compounded t time
    | Compounding.CompoundedThenSimple -> if time > 1.0 /. t.freq then simple t time else compounded t time
