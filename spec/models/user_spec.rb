require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  it 'is invalid without name' do
    expect(FactoryGirl.build(:user, name: nil)).not_to be_valid
  end
  it 'is invalid without login' do
    expect(FactoryGirl.build(:user, login: nil)).not_to be_valid
  end
  it 'email should has valid format' do
    expect(FactoryGirl.build(:user, email: 'test@wp.pl')).to be_valid
    expect(FactoryGirl.build(:user, email: 'sss')).not_to be_valid
  end
  it 'login should be unique' do
    FactoryGirl.create(:user, login:'test')
    expect(FactoryGirl.build(:user, login:'test')).not_to be_valid
  end
  it 'email should be unique' do
    FactoryGirl.create(:user, email:'test@test.pl')
    expect(FactoryGirl.build(:user, email:'test@test.pl')).not_to be_valid
  end
  it 'should downcase email before save' do
    item = FactoryGirl.create(:user, email: 'AbC@Op.pl')
    expect(item.email).to eq 'abc@op.pl'
  end

end
