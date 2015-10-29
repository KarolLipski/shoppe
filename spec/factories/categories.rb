# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
