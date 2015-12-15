# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  item_id     :integer
#  quantity    :integer
#  price       :decimal(10, 2)
#  total_price :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  before_validation :count_total_price

  validates_presence_of  :item, :quantity, :price, :total_price
  validates :quantity, numericality: {only_integer: true, greater_than: 0}, total_quantity: true
  validates :price, :total_price, numericality: true


  def total_price
   read_attribute(:total_price) || (price * quantity)
  end

  def count_total_price
    self.total_price = (price * quantity)
  end

  def cart_item_id
    @cart_item_id
  end
  def cart_item_id=(val)
    @cart_item_id = val
  end
end
