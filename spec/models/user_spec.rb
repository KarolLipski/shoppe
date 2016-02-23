# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  contractor_sym  :string(255)
#  reciver_sym     :string(255)
#  email           :string(255)
#  login           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it 'is invalid without name' do
    expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
  end
  it 'is invalid without contractor symbol' do
    expect(FactoryGirl.build(:user, contractor_sym: nil)).not_to be_valid
  end
  it 'is invalid without reciver symbol' do
    expect(FactoryGirl.build(:user, reciver_sym: nil)).not_to be_valid
  end
  it 'is invalid without login' do
    expect(FactoryGirl.build(:user, login: nil)).not_to be_valid
  end
  it 'is valid without email' do
    expect(FactoryGirl.build(:user, email: nil)).to be_valid
  end
  it 'is invalid without password' do
    expect(FactoryGirl.build(:user, password: nil)).not_to be_valid
  end
  it 'email should has valid format' do
    expect(FactoryGirl.build(:user, email: 'test@wp.pl')).to be_valid
    expect(FactoryGirl.build(:user, email: 'sss')).not_to be_valid
  end
  it 'pair login and password should be unique' do
    FactoryGirl.create(:user, login:'test', password:'zxczxc', password_confirmation: 'zxczxc')
    expect(FactoryGirl.build(:user, login:'test', password:'zxczxc', password_confirmation: 'zxczxc')).not_to be_valid
    expect(FactoryGirl.build(:user, login:'test', password:'zx', password_confirmation: 'zx')).to be_valid
    expect(FactoryGirl.build(:user, login:'login', password:'zxczxc', password_confirmation: 'zxczxc')).to be_valid
  end
  it 'should downcase email before save' do
    item = FactoryGirl.create(:user, email: 'AbC@Op.pl')
    expect(item.email).to eq 'abc@op.pl'
  end

end
