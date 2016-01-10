require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do

  describe 'GET #actualization' do

    it 'assigns last 3 actualizations' do
      actualizations =  double("actualizations");
      expect(ActualizationLog).to receive(:order).with('created_at DESC').and_return(actualizations)
      expect(actualizations).to receive(:first).with(3).and_return(actualizations)
      get :actualization
      expect(assigns(:actualizations)).to eq actualizations
    end

    it 'renders with admin layout' do
      get :actualization
      expect(response).to render_template(layout: 'admin')
    end
  end

  describe 'GET #actualize' do
    before(:each) do
      @file = fixture_file_upload('stany.csv')
    end
    it 'saves file in public/actualization' do
      expect(controller).to receive(:save_uploaded_file).with(@file)
      post :actualize, file: @file
    end
    it 'creates new backgroud job for ItemsImporter' do
      importer = double('importer')
      expect(CsvImporter::ItemsImporter).to receive(:new).and_return(importer)
      expect(importer).to receive(:delay).and_return(importer)
      expect(importer).to receive(:actualize)
      post :actualize, file: @file
    end
    it 'creates new row in actualizationLog with Accepted status' do
      post :actualize, file: @file
      expect(assigns(:log).status).to eq('Accepted')
    end
    it 'redirects to actualization page' do
      post :actualize, file: @file
      expect(response).to redirect_to action: :actualization
    end
  end

  describe 'GET #noCategories' do
    it 'assigns only items with quantity and photo' do
      item1 = FactoryGirl.create(:item, category: nil) # without quantity
      item2 = FactoryGirl.create(:item_with_stored, category: nil) # without photo
      item2.update_column(:photo, nil)
      item3 = FactoryGirl.create(:item_with_stored, category: nil) # without photo

      get :no_categories
      expect(assigns(:items).first).to eq item3
    end
  end

end
