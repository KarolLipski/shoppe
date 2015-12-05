# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  item_id    :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  validates_presence_of :cart, :item, :quantity
  validates_numericality_of :quantity , { only_integer: true, greater_than_or_equal_to: 0}
  validate :less_equal_total_stored , if: Proc.new { |c| !c.item.nil? && !c.quantity.blank? }

  after_save :update_cart_sum
  after_destroy :update_cart_sum

  # Updates cart summary price
  def update_cart_sum
    cart.recalc_sum
  end

  # Validates if quantity is not greather than total stored
  def less_equal_total_stored
    total = item.quantity
    errors.add(:quantity, "nie dostępna. Maksymalna dostępna to: #{total} szt.") if quantity > total
  end

end
