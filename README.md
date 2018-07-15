# businessdays

This is an implementation of business calendars used in fixed income. It is a port of quantlib's implementation.

Example:

To calculate the number of days using "30/360" bond basis convention. You call the following code

```ocaml    
    Thirty_360.BondBasis.day_count (Date.create_exn 2018 Jan 31) (Date.create_exn 2018 Feb 28) 
```