FactoryGirl.define do
  factory :stored_item do
    association :magazine , factory: :magazine
    association :item , factory: :item
    quantity 120
    price "9.99"
  end

end
