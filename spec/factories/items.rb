# encoding: utf-8
# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  number      :string(255)
#  name        :string(255)
#  small_wrap  :integer
#  big_wrap    :integer
#  photo       :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  barcode     :string(13)
#  active      :boolean          default(TRUE)
#

FactoryGirl.define do
  factory :item do
    number "1230023456"
    name "Wózek na kółkach"
    small_wrap 12
    big_wrap 48
    photo nil
    association :category, factory: :category
    after :create do |i|
      i.update_column(:photo, '23456.jpg')
    end
    factory :item_with_stored do
      after :create do |i|
        i.stored_items << FactoryGirl.create(:stored_item, item: i)
      end
    end
  end

end
