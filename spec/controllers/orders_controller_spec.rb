require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  def prepare_data
    @user = FactoryGirl.create(:user)
    log_in(@user)
    @cart = current_cart
    # @cart.cart_items << FactoryGirl.create(:cart_item, cart: @cart)
    @cart_items = FactoryGirl.create_list(:cart_item, 3, cart: @cart)
    @cart.reload
  end

  def prepare_valid_attributes
    order_items_attr = Hash.new
    @cart_items.each_with_index do |cart_item, i|
      order_items_attr[i.to_s] = { "price" => cart_item.item.price.to_s,
                                   "item_id" => cart_item.item.id,
                                   "cart_item_id" => cart_item.id,
                                   "quantity" => cart_item.quantity }
    end
    @valid_attributes = {"order" => {"order_items_attributes"=> order_items_attr} }
  end

  describe 'GET new' do
    before(:each) do
      prepare_data
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
      prepare_data
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
      prepare_data
      prepare_valid_attributes
    end
    it 'assings current user' do
      post :create, @valid_attributes
      expect(assigns(:user)).to eq(@user)
    end
    it 'assigns current cart' do
      post :create, @valid_attributes
      expect(assigns(:cart)).to eq(@cart)
    end
    it 'sets total order price' do
      post :create, @valid_attributes
      # 3 factory quantity(1)X factory price(9.99)
      expect(assigns(:order).price).to eq(29.97)
    end
    context 'when all items are valid' do
      before(:each) do
        post :create, @valid_attributes
      end
      it 'redirect to home page' do
        expect(response).to redirect_to root_path
      end
      it 'sets success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'when some items are invalid' do
      before(:each) do
        @valid_attributes["order"]["order_items_attributes"]["0"]["quantity"] = 'sss'
        post :create, @valid_attributes
      end
      it 'sets error flash' do
        expect(flash[:danger]).to be_present
      end
      it 'render new template' do
        expect(response).to render_template :new
      end
      it 'doesnt create order' do
        expect(assigns[:order].persisted?).to eq false
      end
    end
  end
end
