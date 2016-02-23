# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :offer do
    name "Oferta 36"
    start_date { Faker::Date.backward(3) }
    end_date { Faker::Date.forward(10)}
  end

end
