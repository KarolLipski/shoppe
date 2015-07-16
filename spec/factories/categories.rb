FactoryGirl.define do
  factory :category do
    name 'kategoria'
    association :parent, factory: :category_root
  end

  factory :category_root, parent: :category do
    name 'kategoria glowna'
    parent nil
  end

end
