# encoding: utf-8
require 'rails_helper'

require "#{Rails.root}/lib/csv_importer/items_importer.rb"

RSpec.describe CsvImporter::ItemsImporter do

  before(:each) do
    @magazine = FactoryGirl.create(:magazine, number: '5016')
    @importer = CsvImporter::ItemsImporter.new
  end

  context 'when in csv is new item' do
    before(:each) do
      @importer.import_items(File.join(Rails.root,'test/fixtures','stany.csv'))
    end
    it 'creates new item' do
      expect(Item.all.size).to eq(3)
    end
    it 'creates new stored item' do
      expect(StoredItem.all.size).to eq(3)
    end
  end

  context 'when in csv is item to update' do
    before(:each) do
      @item = FactoryGirl.create(:item, number: '1110000095', name: 'name')
      FactoryGirl.create(:stored_item, magazine: @magazine, item: @item)
      @importer.import_items(File.join(Rails.root,'test/fixtures','stany.csv'))
    end
    it 'updates price' do
      expect(StoredItem.find_by(item_id: @item.id).price).to eq(5.23)
    end
    it 'updates quantity' do
      expect(StoredItem.find_by(item_id: @item.id).quantity).to eq(10)
    end
    it 'doesnt update name' do
      @item.reload
      expect(@item.name).to eq('name')
    end
    it 'doesnt create new item' do
      expect(Item.count).to eq(3) # 3 items in csv , 1 item in db
    end
    it 'doesnt create new stored_item' do
      expect(StoredItem.count).to eq(3) # 3 items in csv , 1 item in db
    end
  end

end