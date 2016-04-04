require 'rails_helper'

feature 'Offer actualization' do

  before :each do
    allow_any_instance_of(AdminController).to receive(:authenticate)
    @offer = FactoryGirl.create(:offer)
  end

  scenario 'with proper data' do
    visit admin_offers_path
    within("#table-standard_datatable") do
      click_link('Towary')
    end
    attach_file 'file', File.join(Rails.root,'test/fixtures','oferta.csv')
    click_button 'Aktualizuj'
    # save_and_open_page
    expect(page).to have_css("table#last-actualizations tr", count: 2)
    within("table#last-actualizations") do
      expect(page).to have_content(/Accepted|In progress/)
    end

  end
end