class Item < ActiveRecord::Base

  validates_presence_of :name, :number, :small_wrap, :big_wrap
  validates_numericality_of :small_wrap, :big_wrap, :only_integer => true, :greater_than_or_equal_to => 0
end
