require 'rails_helper'

feature 'users listing' do

  before(:each) do
    (1..3).each do |i|
      FactoryGirl.create(:user,login:"user_#{i}", password:"pass_#{i}", password_confirmation:"pass_#{i}")
    end
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end
  scenario 'list all users' do
    visit admin_users_path
    within("table#table-standard_datatable") do
      expect(page).to have_css("tr", count:4)
    end
  end
end

feature 'edit users' do
  before(:each) do
    allow_any_instance_of(AdminController).to receive(:authenticate)
    @user = FactoryGirl.create(:user)
    visit edit_admin_user_path @user
  end
  context 'when data is valid' do
    before(:each) do
      fill_in 'user_name', with: 'firma'
      fill_in 'user_contractor_sym', with: '203'
      fill_in 'user_reciver_sym', with: '203'
      fill_in 'user_login', with: 'login'
      fill_in 'user_email', with: 'email@wp.pl'
      click_button 'Zapisz'
    end
    scenario 'display success info' do
      expect(page.html).to include("toastr.success('Dane użytkownika zostały zmienione','',opts);")
    end
    scenario 'redirect to users list' do
        expect(page).to have_selector 'h3', text: 'Klienci'
    end
  end
  context 'when data is invalid' do
    scenario 'display error info' do
      fill_in 'user_name', with: ''
      click_button 'Zapisz'
      expect(page.html). to include("toastr.error('Błąd zapisu','',opts);")
    end
  end
end

feature 'create user' do
  before(:each) do
    allow_any_instance_of(AdminController).to receive(:authenticate)
    visit new_admin_user_path
  end
  context 'when data is valid' do
    before(:each) do
      fill_in 'user_name', with: 'firma'
      fill_in 'user_contractor_sym', with: '203'
      fill_in 'user_reciver_sym', with: '203'
      fill_in 'user_login', with: 'login'
      fill_in 'user_email', with: 'email@wp.pl'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Zapisz'
    end
    scenario 'display success info' do
      expect(page.html).to include("toastr.success('Klient został dodany','',opts);")
    end
    scenario 'redirect to users list' do
      expect(page).to have_selector 'h3', text: 'Klienci'
    end
  end
  context 'when data is invalid' do
    scenario 'display error info' do
      fill_in 'user_name', with: ''
      click_button 'Zapisz'
      expect(page.html). to include("toastr.error('Błąd zapisu','',opts);")
    end
  end
end