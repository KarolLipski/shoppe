# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price_sum  :decimal(10, 2)   default(0.0)
#

class Cart < ActiveRecord::Base
  has_many :cart_items
  belongs_to :user

  validates_presence_of :user

  def recalc_sum
    sum = cart_items.inject(0) { |sum, n| sum + (n.item.price * n.quantity)}
    update(price_sum: sum)
  end

  def make_empty
    cart_items.delete_all
    update(price_sum: 0)
  end
end
