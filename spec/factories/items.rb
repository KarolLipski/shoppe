# encoding: utf-8
# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  number      :string
#  name        :string
#  small_wrap  :integer
#  big_wrap    :integer
#  photo       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

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
