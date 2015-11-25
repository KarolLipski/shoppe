class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  validates_presence_of :cart, :item, :quantity
  validates_numericality_of :quantity , { only_integer: true, greater_than_or_equal_to: 0}
end
