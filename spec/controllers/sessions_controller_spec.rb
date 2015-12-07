require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET New' do
    it 'renders new template' do
      get :new
      expect(controller).to render_template(:new)
    end
  end

  describe 'POST Create' do
    before(:each) do
      @user = FactoryGirl.create(:user, login: 'test_login')
      @proper_attributes = FactoryGirl.attributes_for(:user)
      @proper_attributes[:login] = 'test_login'

    end
    context 'when data is valid' do
      before(:each) do
        post :create, {session: @proper_attributes}
      end
      it 'should login user' do
        expect(session[:user_id]).to eq(@user.id)
      end
      it 'should redirect to root' do
        expect(response).to redirect_to(root_path)
      end
    end
    context 'when data is invalid' do
      before(:each) do
        post :create, {session: {login: 'aaa', password: 'cfd'}}
      end
      it 'should not login user' do
        expect(session[:user_id]).to be_nil
      end
      it 'should set error flash' do
        expect(flash[:danger]).to be_present
      end
      it 'should reneder new template' do
        expect(controller).to render_template(:new)
      end
    end
  end

  describe 'GET Destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      get :destroy
    end
    it 'should logout user' do
      expect(session[:user_id]).to be_nil
    end
    it 'should redirect to root' do
      expect(response).to redirect_to(root_path)
    end
  end

end
