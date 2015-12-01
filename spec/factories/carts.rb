# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price_sum  :decimal(10, 2)   default(0.0)
#

FactoryGirl.define do
  factory :cart do
    association :user, factory: :user
  end

end
