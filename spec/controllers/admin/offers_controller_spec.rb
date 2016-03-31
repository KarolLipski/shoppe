require 'rails_helper'

RSpec.describe Admin::OffersController, type: :controller do

  before :each do
    controller.stub(:authenticate)
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

end
