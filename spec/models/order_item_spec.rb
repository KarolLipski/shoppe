# == Schema Information
#
# Table name: order_items
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  item_id     :integer
#  quantity    :integer
#  price       :decimal(10, 2)
#  total_price :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:order_item)).to be_valid
  end
  it 'is invalid without order' do
    expect(FactoryGirl.build(:order_item, order: nil)).not_to be_valid
  end
  it 'is invalid without stored_item' do
    expect(FactoryGirl.build(:order_item, stored_item: nil)).not_to be_valid
  end
  it 'is invalid without quantity' do
    expect(FactoryGirl.build(:order_item, quantity: nil)).not_to be_valid
  end
  it 'quantity should be numerical' do
    expect(FactoryGirl.build(:order_item, quantity: 'avd')).not_to be_valid
  end
  it 'quantity should be greathe than 0' do
    expect(FactoryGirl.build(:order_item, quantity: 0)).not_to be_valid
  end
  it 'is invalid without price' do
    expect(FactoryGirl.build(:order_item, price: nil)).not_to be_valid
  end
  it 'price should by numerical' do
    expect(FactoryGirl.build(:order_item, price: 'avc')).not_to be_valid
    expect(FactoryGirl.build(:order_item, price: 10.34)).to be_valid
  end
  it 'pick stored item from magazine after save' do
    order_item = FactoryGirl.build(:order_item)
    order_item.update!(:quantity => 100)
    expect(order_item.stored_item.quantity).to eq 20
  end
end
