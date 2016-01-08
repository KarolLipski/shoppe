# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  cart_id    :integer
#  item_id    :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:cart_item)).to be_valid
  end
  it 'is invalid without cart' do
    expect(FactoryGirl.build(:cart_item, cart: nil)).not_to be_valid
  end
  it 'is invalid without item' do
    expect(FactoryGirl.build(:cart_item, stored_item: nil)).not_to be_valid
  end
  it 'is invalid without quantity' do
    expect(FactoryGirl.build(:cart_item, quantity: nil)).not_to be_valid
  end
  it 'quantity should be only numeric' do
    expect(FactoryGirl.build(:cart_item, quantity: 'asd')).not_to be_valid
  end
  it 'is ivalid if quantity is greather than total stored ' do
    expect(FactoryGirl.build(:cart_item, quantity: 2000)).not_to be_valid
  end
  it 'quantity should be only >= 0' do
    cart_item = FactoryGirl.build(:cart_item, quantity: -2);
    expect(cart_item).not_to be_valid
    cart_item.quantity = 0
    expect(cart_item).to be_valid
  end
  it 'quantity shouldnt be float' do
    expect(FactoryGirl.build(:cart_item, quantity: 9.32)).not_to be_valid
  end
end
