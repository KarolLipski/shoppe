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

FactoryGirl.define do
  factory :order_item do
    association :order, factory: :order
    association :item, factory: :item_with_stored
    quantity 10
    price 10.01
    total_price 100.10
  end

end