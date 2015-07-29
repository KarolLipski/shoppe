# encoding: utf-8
FactoryGirl.define do
  factory :item do
    number "1230023456"
    name "Wózek na kółkach"
    small_wrap 12
    big_wrap 48
    photo nil
    association :category, factory: :category
  end

end
