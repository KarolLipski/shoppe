require 'rails_helper'

feature 'Main page' do
  scenario 'show all reccomendation' do
    main_page = Pages::MainRoot.new
    main_page.visit_page
    expect(main_page).to be_on_page
    expect(page).to have_selector('.best-seller-pro', count: 3)
  end
end