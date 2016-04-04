require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:item)
  }
  let(:invalid_attributes) {
    invalid = FactoryGirl.attributes_for(:item)
    invalid['name'] = nil
    invalid
  }

  before :each do
    controller.stub(:authenticate)
  end

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

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        attributes = FactoryGirl.attributes_for(:item)
        attributes['name'] = 'updated_name'
        attributes
      }
      before(:each) do
        @item = Item.create! valid_attributes
      end

      it 'updates the requested item' do
        xhr :put, :update, {:id => @item.to_param, :item => new_attributes}
        @item.reload
        expect(@item.name).to eq 'updated_name'
      end

      it 'assigns the requested items as @item' do
        xhr :put, :update, {:id => @item.to_param, :item => valid_attributes}
        expect(assigns(:item)).to eq(@item)
      end

      # it 'render json without errors' do
      #   xhr :put, :update, {id: @item.id, :item => valid_attributes}
      #   parsed_body = JSON.parse(response.body)
      #   expect(parsed_body['errors']).to eq nil
      # end

    end

    context 'with invalid params' do
      it 'assigns the item as @item' do
        @item = Item.create! valid_attributes
        xhr :put, :update, {:id => @item.to_param, :item => invalid_attributes}
        expect(assigns(:item)).to eq(@item)
      end

      it 'render json with errors' do
        @item = Item.create! valid_attributes
        xhr :put, :update, {:id => @item.to_param, :item => invalid_attributes}
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['errors']).not_to eq nil
      end
    end
  end

  describe 'POST #actualize' do
    context 'actualize stored' do
      before(:each) do
        @file = fixture_file_upload('stany.csv')
      end
      it 'saves file in public/actualization' do
        expect(controller).to receive(:save_uploaded_file).with(@file,'actualization')
        post :actualize, file: @file, type: 'actualization'
      end
      it 'creates new backgroud job for ItemsImporter' do
        importer = double('importer')
        expect(CsvImporter::ItemsImporter).to receive(:new).and_return(importer)
        expect(importer).to receive(:delay).and_return(importer)
        expect(importer).to receive(:actualize)
        post :actualize, file: @file, type: 'actualization'
      end
      it 'creates new row in actualizationLog with Accepted status' do
        post :actualize, file: @file, type: 'actualization'
        expect(assigns(:log).status).to eq('Accepted')
      end
      it 'redirects to actualization page' do
        post :actualize, file: @file, type: 'actualization'
        expect(response).to redirect_to action: :actualization
      end
    end
    context 'import offer items' do
      before(:each) do
        @file = fixture_file_upload('oferta.csv')
      end
      it 'save file in public/actualization' do
        expect(controller).to receive(:save_uploaded_file).with(@file, 'offer_import')
        post :actualize, file: @file, type: 'offer_import'
      end
      it 'creates new backgroudJob for ItemsImporter' do
        importer = double('importer')
        expect(CsvImporter::ItemsImporter).to receive(:new).and_return(importer)
        expect(importer).to receive(:delay).and_return(importer)
        expect(importer).to receive(:actualize)
        post :actualize, file: @file, type: 'offer_import'
      end
      it 'creates new row in actualizationLog with Accepted status' do
        post :actualize, file: @file, type: 'offer_import'
        expect(assigns(:log).status).to eq('Accepted')
      end
      it 'redirects to actualization page'
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

  describe 'GET #noPhotos' do

  end

end
