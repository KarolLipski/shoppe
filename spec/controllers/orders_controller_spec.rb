require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe 'GET new' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      @cart = current_cart
      @cart.cart_items << FactoryGirl.create(:cart_item, cart: @cart)
      @cart.reload
    end
    it 'creates build new Order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
    it 'builds order items based on cart_items' do
      get :new
      expect(assigns(:order).order_items.size).to eq(@cart.cart_items.size)
    end
    it 'assigns current user' do
      get :new
      expect(assigns(:user)).to eq(@user)
    end
    it 'assigns current cart' do
      get :new
      expect(assigns(:cart)).to eq(@cart)
    end
    it 'renders new template' do
      get :new
      expect(response).to render_template('new')
    end
    it 'calls check_cart' do
      expect(controller).to receive(:check_cart)
      get :new
    end
  end

  describe 'Check cart before action' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      @cart = current_cart
      @cart.cart_items << FactoryGirl.create(:cart_item, cart: @cart)
      @cart.reload
    end
    context 'when there is no cart' do
      it 'assings flash' do
        log_out
        get :new
        expect(flash[:warning]).to be_present
      end
    end
    context 'when there is no user ' do
      it 'assings flash' do
        log_out
        get :new
        expect(flash[:warning]).to be_present
      end
    end
    context 'when cart is empty ' do
      it 'assings flash' do
        @cart.cart_items.clear
        get :new
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'POST create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in @user
      @cart = current_cart
      @cart_items = FactoryGirl.create_list(:cart_item, 3, cart: @cart)
      @quantities = @cart_items.map { |i| [i.id.to_s, "1"]}.to_h
      @cart.reload
    end
    it 'assings current user' do

    end
    it 'assigns current cart' do

    end
    it 'sets total order price' do

    end
    context 'when all items are valid' do
      before(:each) do

      end
      it 'redirect to home page' do

      end
      it 'sets success flash' do

      end
    end
    context 'when some items are invalid' do
      before(:each) do

      end
      it 'sets error flash' do

      end
      it 'render new template' do

      end
      it 'doesnt create order' do

      end
    end
  end
end
