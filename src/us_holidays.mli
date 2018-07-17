open! Core_kernel 

val adjust_if_weekend: Date.t -> Date.t
(** [adjust_if_weekend dt] adjust [dt] if [dt] is weekend*)

val is_new_year_day: Date.t -> bool
(** [is_new_year_day dt] return whether a date is New Year's Day, 
  January 1st (possibly moved to Monday if actually on Sunday, or
  to Friday if on Saturday) *)

val is_martin_luther_king_birthday: Date.t -> bool
(** [is_martin_luther_king_birthday dt] whether [dt] is Martin Luther 
   King's birthday, third Monday in January (since 1983) *)

val is_washington_birthday: Date.t -> bool 
(** [is_washington_birthday dt] whether [dt] is Presidents' Day 
  (a.k.a. Washington's birthday), third Monday in February *)

val is_memorial_day: Date.t -> bool 
(** [is_memorial_day dt] whether [dt] is Memorial Day, last Monday in May *)

val is_independence_day: Date.t -> bool
(** Independence Day, July 4th (moved to Monday if Sunday or Friday if Saturday) *)

val is_labor_day: Date.t -> bool
(** Labor Day, first Monday in September *)

val is_columbus_day: Date.t -> bool
(** Columbus Day, second Monday in October *)

val is_veterans_day: Date.t -> bool
(** Veterans' Day, November 11th (moved to Monday if Sunday or Friday if Saturday) *)

val is_thanksgiving_day: Date.t -> bool
(** Thanksgiving Day, fourth Thursday in November *)

val is_chrismas_day: Date.t -> bool
(** Christmas, December 25th (moved to Monday if Sunday or Friday if Saturday)*)

val is_good_friday: Date.t -> bool
(** [is_good_friday dt] whether it is good Friday. *)

module type Holidays = sig
  val is_holiday: Date.t -> bool
end

module Settlement : sig
  include Holidays
end

module Libor_impact : sig
  include Holidays
end

module Government_bond : sig
  include Holidays
end
