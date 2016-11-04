require 'rails_helper'

RSpec.describe "Users", :type => :request do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:user)
  }

  let(:invalid_attributes) {
    invalid = FactoryGirl.attributes_for(:user)
    invalid['login'] = nil
    invalid
  }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end

  describe 'index' do
    it 'should render template index' do
      get admin_users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'new' do
    it 'should render new template' do
      get new_admin_user_path
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    context 'with valid params' do
      before :each do
        post admin_users_path, {:user => valid_attributes}, valid_session
      end
      it 'should create new user' do
        expect(User.count).to eql 1
      end
      it 'should redirect to users list' do
        expect(response).to redirect_to admin_users_path
      end
      it 'should set success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'with invalid params' do
      before :each do
        post admin_users_path, {:user => invalid_attributes}, valid_session
      end
      it 'should not create any user' do
        expect(User.count).to eql 0
      end
      it 'should render new template' do
        expect(response).to render_template(:new)
      end
      it 'should set danger flash' do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe 'update' do
    context 'with valid params' do
      before :each do
        @user = FactoryGirl.create(:user, name: 'test_name')
        put admin_user_path(:id => @user.id), {:user => valid_attributes}, valid_session
      end
      it 'should update user data' do
        expect(User.first.name).not_to eq(@user.name)
      end
      it 'should redirect to index' do
        expect(response).to redirect_to admin_users_path
      end
      it 'should set success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'with invalid params' do
      before :each do
        @user = FactoryGirl.create(:user, name: 'test_name')
        put admin_user_path(:id => @user.id), {:user => invalid_attributes}, valid_session
      end
      it 'should not update user' do
        expect(User.find(@user.id).name).to eq(@user.name)
      end
      it 'should render edit template' do
        expect(response).to render_template(:edit)
      end
      it 'should set danger flash' do
        expect(flash[:danger]).to be_present
      end
    end
  end

end