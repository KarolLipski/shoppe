# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  price      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:order)).to be_valid
  end
  it 'is invalid without user' do
    expect(FactoryGirl.build(:order, user: nil)).not_to be_valid
  end
  it 'is invalid without price' do
    expect(FactoryGirl.build(:order, price: nil)).not_to be_valid
  end
  it 'price should by numerical' do
    expect(FactoryGirl.build(:order_item, price: 'avc')).not_to be_valid
    expect(FactoryGirl.build(:order_item, price: 10.34)).to be_valid
  end
end
