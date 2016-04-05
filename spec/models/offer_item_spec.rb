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
#  type        :string(255)
#  offer_id    :integer
#

require 'rails_helper'

RSpec.describe OfferItem, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:offer_item)).to be_valid
  end

  it 'is invalid without item' do
    expect(FactoryGirl.build(:offer_item, item_id: nil)).not_to be_valid
  end

  it 'is valid without magazine' do
    expect(FactoryGirl.build(:offer_item, magazine_id: nil)).to be_valid
  end

  it 'is invalid without price' do
    expect(FactoryGirl.build(:offer_item, price: nil)).not_to be_valid
  end

  it 'is valid without quantity' do
    expect(FactoryGirl.build(:offer_item, quantity: nil)).to be_valid
  end

end
