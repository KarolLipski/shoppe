require 'rails_helper'

feature 'Items actualization' do

  scenario 'with proper data' do
    visit items_actualization_path
    attach_file 'file', File.join(Rails.root,'test/fixtures','stany.csv')
    click_button 'Aktualizuj'
    # save_and_open_page
    expect(
      find('tr', text: Time.now.strftime('%Y-%m-%d'))
    ).to have_content(/Accepted|In progress/)
  end

  scenario 'show last 3 aktualizations' do
    4.times do
      FactoryGirl.create(:actualization_log)
    end

    visit items_actualization_path
    expect(page).to have_css("table tr", count: 4)
  end
end