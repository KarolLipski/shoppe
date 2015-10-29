# == Schema Information
#
# Table name: stored_items
#
#  id          :integer          not null, primary key
#  magazine_id :integer
#  item_id     :integer
#  quantity    :integer
#  price       :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe StoredItem, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:stored_item)).to be_valid
  end

  it 'is invalid without item' do
    expect(FactoryGirl.build(:stored_item, item_id: nil)).not_to be_valid
  end

  it 'is invalid without magazine' do
    expect(FactoryGirl.build(:stored_item, magazine_id: nil)).not_to be_valid
  end

  it 'is invalid without price' do
    expect(FactoryGirl.build(:stored_item, price: nil)).not_to be_valid
  end

  it 'is invalid without quantity' do
    expect(FactoryGirl.build(:stored_item, quantity: nil)).not_to be_valid
  end

end
