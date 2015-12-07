require 'rails_helper'

feature 'authentication' do
  feature 'login' do
    before(:each) do
      FactoryGirl.create(:user, login: 'test_login')
    end

    context 'with proper data' do
      before(:each) do
        @proper_attributes = FactoryGirl.attributes_for(:user)
        @proper_attributes[:login] = 'test_login'
      end
      scenario 'should login user' do
        visit login_path
        fill_in 'Login', with: @proper_attributes[:login]
        fill_in 'Hasło', with: @proper_attributes[:password]
        click_button 'Logowanie'
        # save_and_open_page
        expect(page).to have_link('Wyloguj')
      end
    end
    context 'with invalid data' do
      scenario 'should display error info' do
        visit login_path
        fill_in 'Login', with: 'log'
        fill_in 'Hasło', with: 'pass'
        click_button 'Logowanie'
        within('.alert-danger') do
          expect(page).to have_content('Login lub hasło jest nie poprawne')
        end
      end
    end

  end
 end