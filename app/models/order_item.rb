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
  belongs_to :order, inverse_of: :order_items
  belongs_to :stored_item

  before_save :count_total_price
  after_save :pick_form_magazine

  validates_presence_of  :stored_item, :quantity, :price, :order
  validates :quantity, numericality: {only_integer: true, greater_than: 0}, total_quantity: true
  validates :price, numericality: true


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

  #removes quantity from magazine
  def pick_form_magazine
    stored_item.update_attribute(:quantity, (stored_item.quantity - quantity))
  end

end
