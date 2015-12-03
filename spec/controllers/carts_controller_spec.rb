require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe 'GET show' do
    before(:each) do
      @cart = FactoryGirl.create(:cart)
      @user = @cart.user
      log_in(@user)
      (1..3).each do |i|
        stored_item = FactoryGirl.create(:stored_item)
        FactoryGirl.create(:cart_item, cart: @cart, item: stored_item.item)
      end
    end
    it 'assigns items' do
      get :show
      expect(assigns(:items).size).to eq(3)
    end
    it 'assigns cart' do
      get :show
      expect(assigns(:cart).user_id).to eq @user.id
    end
    it 'renders show template' do
      get :show
      expect(response).to render_template('show')
    end
  end

  describe 'GET Init_add' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      @item = FactoryGirl.create(:item)
      xhr :get, :init_add, item_id: @item.id
    end
    it 'assigns item' do
      expect(assigns(:item)).to eq(@item)
    end
    it 'assigns current_cart' do
      expect(assigns(:current_cart).user_id).to eq @user.id
    end
    it 'renders init_add template' do
      expect(response).to render_template('init_add')
    end
  end



end
