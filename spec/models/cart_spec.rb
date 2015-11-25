# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Cart, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:cart)).to be_valid
  end
  it 'is invalid without user' do
    expect(FactoryGirl.build(:cart, user: nil)).not_to be_valid
  end
end
