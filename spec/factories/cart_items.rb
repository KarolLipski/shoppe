# == Schema Information
#
# Table name: cart_items
#
#  id             :integer          not null, primary key
#  cart_id        :integer
#  quantity       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  stored_item_id :integer
#

FactoryGirl.define do
  factory :cart_item do
    association :cart, factory: :cart
    association :stored_item, factory: :stored_item
    quantity 1
  end

end
