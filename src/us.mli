open! Core_kernel 

val adjust_weekend_holiday_US: Date.t -> Date.t

(** New Year's Day, January 1st (possibly moved to Monday if
            actually on Sunday, or to Friday if on Saturday) *)
val is_new_year_day: Date.t -> bool

(** Martin Luther King's birthday, third Monday in January (since 1983) *)
val is_martin_luther_king_birthday: Date.t -> bool

(** Presidents' Day (a.k.a. Washington's birthday), third Monday in February *)
val is_washington_birthday: Date.t -> bool 

(** Memorial Day, last Monday in May *)
val is_memorial_day: Date.t -> bool 

(** Independence Day, July 4th (moved to Monday if Sunday or Friday if Saturday) *)
val is_independence_day: Date.t -> bool

(** Labor Day, first Monday in September *)
val is_labor_day: Date.t -> bool

(** Columbus Day, second Monday in October *)
val is_columbus_day: Date.t -> bool

(** Veterans' Day, November 11th (moved to Monday if Sunday or Friday if Saturday) *)
val is_veterans_day: Date.t -> bool

(** Thanksgiving Day, fourth Thursday in November *)
val is_thanksgiving_day: Date.t -> bool

(** Christmas, December 25th (moved to Monday if Sunday or Friday if Saturday)*)
val is_chrismas_day: Date.t -> bool

module Settlement : sig
  include Holidayable_intf.S
end

module Libor_impact : sig
  include Holidayable_intf.S
end

module Government_bond : sig
  include Holidayable_intf.S
end
