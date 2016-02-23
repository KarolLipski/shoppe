FactoryGirl.define do
  factory :offer do
    name "Oferta 36"
    start_date { Faker::Date.backward(3) }
    end_date { Faker::Date.forward(10)}
  end

end
