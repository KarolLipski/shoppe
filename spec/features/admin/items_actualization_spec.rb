require 'rails_helper'

feature 'Items actualization' do
  scenario 'with proper data' do
    visit items_actualization_path
    attach_file 'file', File.join(Rails.root,'test/fixtures','stany.csv')
    click_button 'Aktualizuj'
    # save_and_open_page
    expect(
      find('tr', text: Time.now.strftime('%Y-%m-%d'))
    ).to have_content(/trakcie|zaakceptowany/)
  end
end