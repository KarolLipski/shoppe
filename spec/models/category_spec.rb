# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do

  it 'has valid factory' do
    expect(FactoryGirl.build(:category)).to be_valid
  end

  it 'has valid category_root factory' do
    expect(FactoryGirl.build(:category_root)).to be_valid
  end

  it 'is invalid without name' do
    expect(FactoryGirl.build(:category, name: nil)).not_to be_valid
  end
end
