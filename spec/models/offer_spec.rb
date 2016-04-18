# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:offer)).to be_valid
  end
  it 'is invalid without name' do
    expect(FactoryGirl.build(:offer, name: nil)).not_to be_valid
  end
  it 'is invalid without start_date' do
    expect(FactoryGirl.build(:offer, start_date: nil)).not_to be_valid
  end
  it 'is invalid without end_date' do
    expect(FactoryGirl.build(:offer, end_date: nil)).not_to be_valid
  end
  context 'active offer' do
    it 'find offer if is active offer' do
      offer = FactoryGirl.create(:offer, start_date: 2.days.ago, end_date: 2.days.from_now)
      expect(Offer.active).to eq offer
    end
    it 'return null if isnt active offer' do
      offer = FactoryGirl.create(:offer, start_date: 10.days.ago, end_date: 2.days.ago)
      expect(Offer.active).to eq nil
    end
    it 'retruns last offer if two ar atvie' do
      offer = FactoryGirl.create(:offer, start_date: 2.days.ago, end_date: 2.days.from_now)
      offer2 = FactoryGirl.create(:offer, start_date: 1.days.ago, end_date: 2.days.from_now)
      expect(Offer.active).to eq offer2
    end
  end
end
