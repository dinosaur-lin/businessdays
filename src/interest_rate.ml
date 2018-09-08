type t = {
    comp: Compounding.t;
    r: float;
    freq: Frequency.t;
}

let simple t time = 1.0 +. t.r *. time

let compounded t time = 
    let f = Frequency.to_float t.freq in
    ((1.0 +. t.r) /. f) ** (f *. time)

let compound_factor t time = 
    match t.comp with
    | Compounding.Simple -> simple t time
    | Compounding.Compounded -> compounded t time
    | Compounding.Continuous -> exp (t.r *. time)
    | Compounding.SimpleThenCompounted -> if time <= 1.0 /. (Frequency.to_float t.freq) then simple t time else compounded t time
    | Compounding.CompoundedThenSimple -> if time > 1.0 /. (Frequency.to_float t.freq) then simple t time else compounded t time

let discount_factor t time = 1.0 /. compound_factor t time