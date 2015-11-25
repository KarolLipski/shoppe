FactoryGirl.define do
  factory :cart_item do
    association :cart, factory: :cart
    association :item, factory: :item
    quantity 1
  end

end
