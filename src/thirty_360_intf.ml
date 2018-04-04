open! Core_kernel

module type Thirty_360 = sig
  module US: Day_counter_intf.S
  module EU: Day_counter_intf.S
  module IT: Day_counter_intf.S
end
