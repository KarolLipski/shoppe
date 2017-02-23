require 'rails_helper'

feature 'Customer login' do
  scenario 'with valid parameters' do
    #setup
    login_page = Pages::Login.new
    login_page.visit_page
    expect(login_page).to be_on_page
    #fill data
    login_page.try_login(:proper_user)
    expect(login_page).to be_on_success_page
  end
  scenario 'with invalid parameters' do
    #setup
    login_page = Pages::Login.new
    login_page.visit_page
    expect(login_page).to be_on_page
    #fill data
    login_page.try_login(:fake_user)
    expect(login_page).to be_on_failure_page
  end
end