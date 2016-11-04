require 'rails_helper'

RSpec.describe "Categories", :type => :request do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:category)
  }

  let(:invalid_attributes) {
    invalid = FactoryGirl.attributes_for(:category)
    invalid['name'] = nil
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
      get admin_categories_path
      expect(response).to render_template(:index)
    end
  end

  describe 'new' do
    it 'should render new template' do
      get new_admin_category_path
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    context 'with valid params' do
      before :each do
        post admin_categories_path, {:category => valid_attributes}, valid_session
      end
      it 'should create new category' do
        expect(Category.count).to eql 1
      end
      it 'should redirect to index' do
        expect(response).to redirect_to admin_categories_path
      end
      it 'should set success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'with invalid params' do
      before :each do
        post admin_categories_path, {:category => invalid_attributes}, valid_session
      end
      it 'should not create any category' do
        expect(Category.count).to eql 0
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
        @category = FactoryGirl.create(:category, name: 'test_name')
        put admin_category_path(:id => @category.id), {:category => valid_attributes}, valid_session
      end
      it 'should update category data' do
        expect(Category.first.name).not_to eq(@category.name)
      end
      it 'should redirect to index' do
        expect(response).to redirect_to admin_categories_path
      end
      it 'should set success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'with invalid params' do
      before :each do
        @category = FactoryGirl.create(:category, name: 'test_name')
        put admin_category_path(:id => @category.id), {:category => invalid_attributes}, valid_session
      end
      it 'should not update category' do
        expect(Category.find(@category.id).name).to eq(@category.name)
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