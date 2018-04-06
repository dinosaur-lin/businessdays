open! Core_kernel

module type Thirty_360 = sig
  module BondBasis: Day_counter_intf.S
  module EuroBondBasis: Day_counter_intf.S
  module Italian: Day_counter_intf.S
end
