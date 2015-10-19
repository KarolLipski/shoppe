require 'rails_helper'

feature 'Search' do

  before(:each) do
    prepre_items
    visit root_path
    fill_in 'search', with: 'test'
    click_button 'search'
  end

  scenario 'request should be GET' do
    uri = URI.parse(current_url)
    expect("#{uri.path}?#{uri.query}").to match(/search=test/)
  end

  feature 'when items exists' do
      scenario 'show page with results' do

      end
  end

  feature 'when items not exists' do
    scenario 'show no result information' do

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