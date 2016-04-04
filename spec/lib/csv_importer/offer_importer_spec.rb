# encoding: utf-8
require 'rails_helper'

require "#{Rails.root}/lib/csv_importer/offer_importer.rb"

RSpec.describe CsvImporter::OfferImporter do

  before(:each) do
    FactoryGirl.create(:category, id: 42)
    @offer = FactoryGirl.create(:offer)
    @importer = CsvImporter::OfferImporter.new
    @importer.offer_id = @offer.id
  end

  context 'actualize' do
    it 'updates log status' do
      log = double('log')
      expect(log).to receive(:update).exactly(2).times
      @importer.actualize(File.join(Rails.root,'test/fixtures','oferta.csv'), log)
    end
    context 'when in csv is new item' do
      before(:each) do
        @importer.import_items(File.join(Rails.root,'test/fixtures','oferta.csv'))
      end
      it 'creates new item' do
        expect(Item.all.size).to eq(3)
      end
      it 'creates new stored item' do
        expect(OfferItem.all.size).to eq(3)
      end
    end

    context 'when in csv is item to update' do
      before(:each) do
        @item = FactoryGirl.create(:item, number: '1110000095', name: 'name')
        FactoryGirl.create(:offer_item, item: @item, offer_id: @offer.id)
        @importer.import_items(File.join(Rails.root,'test/fixtures','oferta.csv'))
      end
      it 'updates price' do
        expect(OfferItem.find_by(item_id: @item.id).price).to eq(5.23)
      end
      it 'doesnt update name' do
        @item.reload
        expect(@item.name).to eq('Name')
      end
      it 'doesnt create new item' do
        expect(Item.count).to eq(3) # 3 items in csv , 1 item in db
      end
      it 'doesnt create new stored_item' do
        expect(OfferItem.count).to eq(3) # 3 items in csv , 1 item in db
      end
    end
  end



end