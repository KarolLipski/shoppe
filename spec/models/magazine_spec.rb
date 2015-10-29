# == Schema Information
#
# Table name: magazines
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Magazine, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:magazine)).to be_valid
  end

  it 'is invalid without number' do
    expect(FactoryGirl.build(:magazine, number: nil)).not_to be_valid
  end

end
