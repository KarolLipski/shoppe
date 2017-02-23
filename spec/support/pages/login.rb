module Pages 
  class Login
    include Capybara::DSL
    include Rails.application.routes.url_helpers

    def initialize
      FactoryGirl.create(:user, login: 'test_login')
      attributes = FactoryGirl.attributes_for(:user)
      @users = {
          proper_user: {login: 'test_login', password: attributes[:password]},
          fake_user: {login: 'fake_login', password: 'xxx'},
      }
    end

    def visit_page
      visit login_path
    end

    def on_page?
      has_selector?('.account-login')
    end

    def on_success_page?
      has_link?('Wyloguj')
    end

    def on_failure_page?
      has_text?('Logowanie do Systemu')
    end

    def try_login(user)
      fill_in 'Login', with: @users[user][:login]
      fill_in 'Hasło', with: @users[user][:password]
      click_button 'Logowanie'
    end



  end
end