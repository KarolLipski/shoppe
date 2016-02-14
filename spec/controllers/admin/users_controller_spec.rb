require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  before :each do
    controller.stub(:authenticate)
  end

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

  describe 'GET new' do
    it 'assigns empty user as @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    let(:attributes) {
      attributes = FactoryGirl.attributes_for(:user)
    }
    context 'with valid params' do
      before(:each) do
        post :create, user: attributes
      end
      it 'saves the user' do
        expect(assigns(:user).new_record?).to eq false
      end
      it 'sets success flash' do
        expect(flash[:success]).to be_present
      end
      it 'redirect to users list' do
        expect(response).to redirect_to(admin_users_path)
      end
    end
    context 'with invalid params' do
      before(:each) do
        attributes['name'] = ''
        post :create, user: attributes
      end
      it 'doesnt save user' do
        expect(assigns(:user).new_record?).to eq true
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
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it 'assign proper user' do
      get :edit, id: @user.to_param
      expect(assigns(:user)).to eq(@user)
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
        attributes['password'] = ''
        attributes['password_confirmation'] = ''
        attributes
      }
      it 'updates user' do
        put :update, {id: @user.to_param, user: new_attributes}
        @user.reload
        expect(@user.name).to eq('new_name')
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
        it 'doesnt change current password' do
          old_pass =  @user.password_digest
          put :update, {id: @user.to_param, user: new_attributes}
          @user.reload
          expect(@user.password_digest).to eq(old_pass)
        end
      end
      context 'when password is set' do
        it 'changes the old password' do
          old_pass =  @user.password_digest
          new_attributes['password'] = 'new pass'
          new_attributes['password_confirmation'] = 'new pass'
          put :update, {id: @user.to_param, user: new_attributes}
          @user.reload
          expect(@user.password_digest).not_to eq(old_pass)
        end
        context 'and confirmation is not same as password' do
          it 'dosent save user' do
            new_attributes['password'] = 'new pass'
            new_attributes['password_confirmation'] = ''
            put :update, {id: @user.to_param, user: new_attributes}
            expect(assigns(:user).errors).not_to be_empty
          end
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