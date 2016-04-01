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

feature 'create offer' do
  before(:each) do
    allow_any_instance_of(AdminController).to receive(:authenticate)
    visit new_admin_offer_path
  end
  context 'when data is valid' do
    before(:each) do
      fill_in 'offer_name', with: 'oferta testowa'
      fill_in 'offer_start_date', with: '2012-01-03'
      fill_in 'offer_end_date', with: '2016-01-01'
      click_button 'Zapisz'
    end
    scenario 'display succes info' do
      expect(page.html).to include("toastr.success('Oferta została dodana','',opts);")
    end
    scenario 'redirects to offer listing' do
      expect(page).to have_selector 'h3', text: 'Oferty'
    end
  end
  context 'when data is invalid' do
    scenario 'display error info' do
      click_button 'Zapisz'
      expect(page.html).to include("toastr.error('Błąd zapisu','',opts);")
    end
  end
end

feature 'edit offer' do
  before(:each) do
    allow_any_instance_of(AdminController).to receive(:authenticate)
    @offer = FactoryGirl.create(:offer)
    visit edit_admin_offer_path @offer
  end
  context 'When data is valid' do
    before(:each) do
      fill_in 'offer_name', with: 'offerxxx'
      click_button 'Zapisz'
    end
    scenario 'display success info' do
      expect(page.html).to include("toastr.success('Oferta została zmieniona','',opts);")
    end
    scenario 'it redirects to offer list' do
      expect(page).to have_selector 'h3', text: 'Oferty'
    end
  end
  context 'when data is invalid' do
    scenario 'display error info' do
      fill_in 'offer_name', with: ''
      click_button 'Zapisz'
      expect(page.html).to include("toastr.error('Błąd zapisu','',opts);")
    end
  end

end