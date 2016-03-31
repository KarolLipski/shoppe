require 'rails_helper'

feature 'offer listing' do
  before(:each) do
    FactoryGirl.create_list(:offer,2)
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end
  scenario 'list all offers' do
    visit admin_offers_path
    within("table#table-standard_datatable") do
      expect(page).to have_css("tr", count:3)
    end
  end
end