require 'rails_helper'

describe ItemActualizator do
  context 'Init' do
    it 'assigns params' do
      act = ItemActualizator.new({type: 'type', offer_id: 'offer_id'})
      expect(act.params).to eq({type: 'type', offer_id: 'offer_id'})
    end
  end
  context 'get_importer' do
    it 'returns ItemsImporter if type is Items' do
      act = ItemActualizator.new({type: 'Items'})
      expect(act.get_importer('Items')).to be_a(CsvImporter::ItemsImporter)
    end
    it 'return OfferImporter if type is Offer' do
      act = ItemActualizator.new({type: 'Offer', offer_id: 'offer_id'})
      expect(act.get_importer('Items')).to be_a(CsvImporter::ItemsImporter)
    end
  end
  it 'actualize_from csv' do
    act = ItemActualizator.new({type: 'Items', offer_id: 'offer_id'})
    allow(act).to receive(:save_file)
    importer = double('importer')
    expect(act).to receive(:get_importer).and_return(importer)
    expect(importer).to receive(:offer_id=)
    expect(importer).to receive(:delay).and_return(importer)
    expect(importer).to receive(:actualize)
    act.actualize_from_csv
  end

end