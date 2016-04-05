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
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end

  describe 'GET #actualization' do

    it 'assigns last 3 Items actualizations' do
      FactoryGirl.create_list(:actualization_log,4)
      get :actualization
      expect(assigns(:actualizations).size).to eq 3
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
      it 'assigns actualizator' do
        post :actualize, file: @file, type: 'Items'
        expect(assigns(:actualizator)).to be_instance_of(ItemActualizator)
      end
      context 'if the is no file' do
        it 'assigns last actualizations logs' do
          post :actualize, type: 'Items'
          expect(assigns(:actualizations))
        end
        it 'renders actualization template' do
          post :actualize, type: 'Items'
          expect(response).to redirect_to admin_items_actualization_path
        end
        it 'sets error flash' do
          post :actualize, type: 'Items'
          expect(flash[:danger]).to be_present
        end
      end
      it 'execute actualizator' do
        act = double('actualizator')
        expect(ItemActualizator).to receive(:new).and_return(act)
        expect(act).to receive(:actualize_from_csv)
        expect(act).to receive(:redirect).and_return(admin_items_actualization_path)
        post :actualize, file: @file, type: 'Items'
      end
      it 'redirects to actualization path' do
        post :actualize, file: @file, type: 'Items'
        expect(response).to redirect_to admin_items_actualization_path
      end
    end
    context 'actualize offer' do
      before(:each) do
        @file = fixture_file_upload('oferta.csv')
      end
      it 'assigns actualizator' do
        post :actualize, file: @file, type: 'Offer', offer_id: 1
        expect(assigns(:actualizator)).to be_instance_of(ItemActualizator)
      end
      context 'if the is no file' do
        it 'assigns last actualizations logs' do
          post :actualize, type: 'Offer', offer_id: 1
          expect(assigns(:actualizations))
        end
        it 'renders actualization template' do
          post :actualize, type: 'Offer', offer_id: 1
          expect(response).to redirect_to admin_offers_actualization_path(offer_id: 1)
        end
        it 'sets error flash' do
          post :actualize, type: 'Offer', offer_id: 1
          expect(flash[:danger]).to be_present
        end
      end
      it 'execute actualizator' do
        act = double('actualizator')
        expect(ItemActualizator).to receive(:new).and_return(act)
        expect(act).to receive(:actualize_from_csv)
        expect(act).to receive(:redirect).and_return(admin_items_actualization_path)
        post :actualize, file: @file, type: 'Offer', offer_id: 1
      end
      it 'redirects to actualization path' do
        post :actualize, file: @file, type: 'Offer', offer_id: 1
        expect(response).to redirect_to admin_offers_actualization_path(offer_id: 1)
      end
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
