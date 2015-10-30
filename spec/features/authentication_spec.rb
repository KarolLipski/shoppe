require 'rails_helper'

feature 'authentication' do
  scenario 'login' do
    FactoryGirl.create(:user)
    attributes = FactoryGirl.attributes_for(:user)
    visit login_path
    fill_in 'Login', with: attributes[:login]
    fill_in 'Hasło', with: attributes[:password]
    click_button 'Logowanie'
    within('.toast-message') do
      expect(page).to have_content('Witaj. Zostałeś poprawnie zalogowany')
    end
    # save_and_open_page
  end
end