# == Schema Information
#
# Table name: offer_items
#
#  id          :integer          not null, primary key
#  magazine_id :integer
#  item_id     :integer
#  quantity    :integer
#  price       :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :offer_item do
    association :item , factory: :item
    association :offer, factory: :offer
    price "9.99"
  end

end
