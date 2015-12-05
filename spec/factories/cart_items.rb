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

FactoryGirl.define do
  factory :cart_item do
    association :cart, factory: :cart
    association :item, factory: :item
    quantity 1
    after(:build) do |cart, evaluator|
      cart.item.stored_items << FactoryGirl.create(:stored_item) unless cart.item.nil?
    end
  end

end
