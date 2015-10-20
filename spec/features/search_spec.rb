require 'rails_helper'

feature 'Search' do

  before(:each) do
    prepre_items
    visit root_path
  end

  scenario 'request should be GET' do
    fill_in 'search', with: 'test'
    click_button 'search'
    uri = URI.parse(current_url)
    expect("#{uri.path}?#{uri.query}").to match(/search=test/)
  end

  feature 'when items exists' do
      scenario 'show page with results' do
        fill_in 'search', with: 'test'
        click_button 'search'
        expect(page).to have_css('div.single-products', count: 3)
      end
  end

  feature 'when items not exists' do
    scenario 'show no result information' do
      fill_in 'search', with: 'no item'
      click_button 'search'
      expect(page).to have_content('Brak wyników')
    end
  end
end

def prepre_items
  (1..3).each do |i|
    FactoryGirl.create(:stored_item,
      item: FactoryGirl.create(:item, name: "test#{i}" )
    )
  end
end