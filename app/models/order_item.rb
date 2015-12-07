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
end
