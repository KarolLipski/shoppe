# == Schema Information
#
# Table name: actualization_logs
#
#  id          :integer          not null, primary key
#  status      :string(255)
#  items_count :integer
#  error       :text(65535)
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
  it 'is invalid without log_type' do
    expect(FactoryGirl.build(:actualization_log, log_type:nil)).not_to be_valid
  end


end
