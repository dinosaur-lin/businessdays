# businessdays

This is an implementation of business calendars used in fixed income. It is a port of quantlib's implementation.

It includes business calendars and day counters.

## Business calendars

To check whether a day is a holiday:

```ocaml
   US.Government_bond.is_holiday (Date.create_exn 2018 Jan 31)
```

What has been implemented:

* US calendar
    - Settlement
    - Libor impact
    - Government bonds

## Day counters

To calculate the number of days or year fraction using "30/360" bond basis convention, we call the following code:

```ocaml    
    Thirty_360.BondBasis.day_count (Date.create_exn 2018 Jan 31) (Date.create_exn 2018 Feb 28)
    Thirty_360.BondBasis.year_frac (Date.create_exn 2018 Jan 31) (Date.create_exn 2018 Feb 28) 
```


What has been implemented:

* "30/360" BondBasis
* "30/360" EuroBondBasis
* "30/360" Italian
* Simple day counter
* Business252