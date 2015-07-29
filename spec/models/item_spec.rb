require 'rails_helper'

RSpec.describe Item, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:item)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:item, name: nil)).not_to be_valid
  end

  it 'is invalid without number' do
    expect(FactoryGirl.build(:item, number: nil)).not_to be_valid
  end

  it 'is invalid without small_wrap' do
    expect(FactoryGirl.build(:item, small_wrap: nil)).not_to be_valid
  end

  it 'is invalid without big_wrap' do
    expect(FactoryGirl.build(:item, big_wrap: nil)).not_to be_valid
  end

  it 'big_wrap should be only number' do
    expect(FactoryGirl.build(:item, big_wrap: 'abc')).not_to be_valid
    expect(FactoryGirl.build(:item, big_wrap: 123)).to be_valid
  end

  it 'small_wrap should be only number' do
    expect(FactoryGirl.build(:item, small_wrap: 'abc')).not_to be_valid
    expect(FactoryGirl.build(:item, small_wrap: 123)).to be_valid
  end

end
