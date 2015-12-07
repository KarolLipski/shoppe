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

  validates_presence_of :order_id, :item_id, :quantity, :price, :total_price
  validates :quantity, numericality: {only_integer: true, greater_than: 0}
  validates :price, :total_price, numericality: true
end
