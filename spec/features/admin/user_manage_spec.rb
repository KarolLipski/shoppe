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

feature 'edit users' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit edit_admin_user_path @user
  end
  context 'when data is valid' do
    before(:each) do
      fill_in 'name', with: 'firma'
      fill_in 'contractor_sym', with: '203'
      fill_in 'receiver_sym', with: '203'
      fill_in 'login', with: 'login'
      fill_in 'email', with: 'email@wp.pl'
      click_button 'Zapisz'
    end
    scenario 'display success info' do
      within('.alert-success') do
        expect(page).to have_content('Zapisano poprawnie')
      end
    end
    scenario 'redirect to users list' do
        expect(page).to have_selector 'h3', text: 'Klienci'
    end
  end
  context 'when data is invalid' do
    scenario 'display error info' do
      click_button 'Zapisz'
      within('alert-danger') do
        expect(page). to have_content('Błąd podczas zapisu')
      end
    end
  end
end