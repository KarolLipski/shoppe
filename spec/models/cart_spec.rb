# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price_sum  :decimal(10, 2)   default(0.0)
#

require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:cart)).to be_valid
  end
  it 'is invalid without user' do
    expect(FactoryGirl.build(:cart, user: nil)).not_to be_valid
  end
  context 'make empty' do
    before(:each) do
      @cart = FactoryGirl.create(:cart)
      FactoryGirl.create_list(:cart_item, 3, cart: @cart)
      @cart.make_empty
    end
    it 'removes all items' do
      expect(@cart.cart_items.count).to eq 0
    end
    it 'change value to 0' do
      expect(@cart.price_sum).to eq 0
    end
  end
end
