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

  describe 'GET edit' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it 'assign proper user' do
      get :edit, id: @user.to_param
      expect(assigns(:user)).to eq(@usser)
    end
  end

  describe 'PUT update' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    context 'with valid params' do
      let(:new_attributes) {
        attributes = FactoryGirl.attributes_for(:user)
        attributes['name'] = 'new_name'
        attributes
      }
      it 'updates user' do
        put :update, {id: @user.to_param, user: new_attributes}
        @user.reload
        expect(@user.name).to eq(new_name)
      end
      it 'assigns user as @user' do
        put :update, {id: @user.to_param, user: new_attributes}
        expect(assigns(:user)).to eq(@user)
      end
      it 'redirects to users index' do
        put :update, {id: @user.to_param, user: new_attributes}
        expect(response).to redirect_to(admin_users_path)
      end
      it 'sets success flash' do
        put :update, {id: @user.to_param, user: new_attributes}
        expect(flash[:success]).to be_present
      end
      context 'when password is not set' do
        before(:each) do
          new_attributes['password'] = ''
          new_attributes['password_confirmation'] = ''
        end
        it 'doesnt change current password' do
          put :update, {id: @user.to_param, user: new_attributes}
          old_pass = FactoryGirl.attributes_for(:user)['password']
          @user.reload
          expect(@user.authenticate(old_pass)).to eq(true)
        end
        it 'redirects to user index' do
          put :update, {id: @user.to_param, user: new_attributes}
          expect(response).to redirect_to(admin_users_path)
        end
      end
    end
    context 'with invalid params' do
      let(:new_attributes) {
        attributes = FactoryGirl.attributes_for(:user)
        attributes['name'] = ''
        attributes
      }
      it 'assigns the user as @user' do
        put :update, {id: @user.to_param, user: new_attributes}
        expect(assigns(:user)).to eq(@user)
      end
      it 'rerenders edit template' do
        put :update, {id: @user.to_param, user: new_attributes}
        expect(response).to render_template('edit')
      end
    end
  end
end