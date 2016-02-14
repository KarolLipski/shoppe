require 'rails_helper'

feature 'Items actualization' do

  before :each do
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end

  scenario 'with proper data' do
    visit admin_items_actualization_path
    attach_file 'file', File.join(Rails.root,'test/fixtures','stany.csv')
    click_button 'Aktualizuj'
    # save_and_open_page
    expect(page).to have_css("table#last-actualizations tr", count: 2)
    within("table#last-actualizations") do
      expect(page).to have_content(/Accepted|In progress/)
    end

  end

  scenario 'show last 3 aktualizations' do
    4.times do
      FactoryGirl.create(:actualization_log)
    end
    visit admin_items_actualization_path
    # save_and_open_page
    expect(page).to have_css("table#last-actualizations tr", count: 4)
  end
end