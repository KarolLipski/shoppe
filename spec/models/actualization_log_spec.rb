# == Schema Information
#
# Table name: actualization_logs
#
#  id          :integer          not null, primary key
#  status      :string
#  items_count :integer
#  error       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ActualizationLog, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:actualization_log)).to be_valid
  end
  it 'is invalid without status' do
    expect(FactoryGirl.build(:actualization_log, status:nil)).not_to be_valid
  end


end
