require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do
    it "assigns category" do
      category = FactoryGirl.create(:category)
      get :index, category_id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET #actualization' do

    it 'assigns last 3 actualizations' do
      actualizations =  double("actualizations");
      expect(ActualizationLog).to receive(:order).with('created_at DESC').and_return(actualizations)
      expect(actualizations).to receive(:last).with(3).and_return(actualizations)
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
    it 'creates new backgroud job for ItemsImporter' do
      importer = double('importer')
      expect(CsvImporter::ItemsImporter).to receive(:new).and_return(importer)
      expect(importer).to receive(:delay).and_return(importer)
      expect(importer).to receive(:import_items)
      post :actualize, file: @file
    end
    it 'creates new row in actualizationLog with Accepted status' do
      post :actualize, file: @file
      expect(assigns(:log).status).to eq('Accepted')
    end
    it 'renders actualiztion template' do
      post :actualize, file: @file
      expect(response).to render_template('actualization')
    end

  end

end
