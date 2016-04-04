require 'rails_helper'

RSpec.describe Admin::OffersController, type: :controller do

  before :each do
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end

  describe 'GET index' do
    it 'assigns offers' do
      offer = FactoryGirl.build(:offer)
      expect(Offer).to receive(:all).and_return(offer)
      get :index
      expect(assigns(:offers)).to eq(offer)
    end
    it 'renders index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'returns 200 status' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    it 'assigns offer' do
      get :new
      expect(assigns(:offer)).to be_a_new(Offer)
    end
  end

  describe 'GET actualization' do
    it 'assigns last actualization' do
      FactoryGirl.create_list(:actualization_log, 2, log_type: 'Offer')
      get :actualization , offer_id: 1
      expect(assigns(:actualizations).size).to eq 1
    end
    it 'renders actualization template' do
      get :actualization, offer_id: 1
      expect(response).to render_template('actualization')
    end
    it 'assigns offer_id' do
      get :actualization, offer_id: 1
      expect(assigns(:offer_id)).to eq "1"
    end
  end

  describe 'POST create' do
    let(:attributes) {
      attributes = FactoryGirl.attributes_for(:offer)
    }
    context 'with valid params' do
      before(:each) do
        post :create , offer: attributes
      end
      it 'save offer' do
        expect(assigns(:offer).new_record?).to eq false
      end
      it 'sets success flash' do
        expect(flash[:success]).to be_present
      end
      it 'redirects to offer index' do
        expect(response).to redirect_to(admin_offers_path)
      end
    end
    context 'with invalid params' do
      before(:each) do
        attributes['name'] = ''
        post :create, offer: attributes
      end
      it 'doesnt save offer' do
        expect(assigns(:offer).new_record?).to eq true
      end
      it 'sets error flash' do
        expect(flash[:danger]).to be_present
      end
      it 'renders new template' do
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET edit' do
    it 'assings proper offer' do
      @offer = FactoryGirl.create(:offer)
      get :edit, id: @offer.to_param
      expect(assigns(:offer)).to eq(@offer)
    end
  end

  describe 'PUT update' do
    let(:attributes) {
      attributes = FactoryGirl.attributes_for(:offer)
      attributes['name'] = 'new_name'
      attributes
    }
    before(:each) do
      @offer = FactoryGirl.create(:offer)
    end
    context 'with valid params' do
      before(:each) do
        put :update, {id: @offer.to_param, offer: attributes}
      end
      it 'assigns user' do
        expect(assigns(:offer)).to eq(@offer)
      end
      it 'updates offer' do
        @offer.reload
        expect(@offer.name).to eq('new_name')
      end
      it 'sets success flash' do
        expect(flash[:success]).to be_present
      end
      it 'redirects to offer index' do
        expect(response).to redirect_to admin_offers_path
      end
    end
    context 'with invalid params' do
      before(:each) do
        attributes['name'] = ''
        put :update, {id: @offer.to_param, offer: attributes}
      end
      it 'assigns offer' do
        expect(assigns[:offer]).to eq(@offer)
      end
      it 'sets error flash' do
        expect(flash[:danger]).to be_present
      end
      it 'rerendes edit template' do
        expect(response).to render_template('edit')
      end
    end

  end

end
