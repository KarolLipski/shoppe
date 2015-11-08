require 'rails_helper'

feature 'users listing' do

  before(:each) do
    (1..3).each do |i|
      FactoryGirl.create(:user,login:"user_#{i}", password:"pass_#{i}", password_confirmation:"pass_#{i}")
    end
  end
  scenario 'list all users' do
    visit admin_users_path
    within("table#table-customers") do
      expect(page).to have_css("tr", count:4)
    end
  end
end