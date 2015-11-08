require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe 'GET index' do
    it 'assigns users' do
      user = FactoryGirl.build(:user)
      expect(User).to receive(:all).and_return(user)
      get :index
      expect(assigns(:users)).to eq(user)
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