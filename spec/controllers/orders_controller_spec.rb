require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe 'POST create' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in @user
      @cart = current_cart
      @cart_items = FactoryGirl.create_list(:cart_item, 3, cart: @cart)
      @cart.reload
    end
    it 'assings current user' do
      post :create
      expect(assigns(:user)).to eq @user
    end
    it 'assigns current cart' do
      post :create
      expect(assigns(:cart)).to eq @cart
    end
    it 'call order service' do
      result = {success: true, order: nil}
      allow_any_instance_of(CreateOrderService).to receive(:call).and_return(result)
      post :create
    end
    context 'when all items are valid' do
      before(:each) do
        result = {success: true, order: nil}
        allow_any_instance_of(CreateOrderService).to receive(:call).and_return(result)
        post :create
      end
      it 'redirect to home page' do
        expect(response).to redirect_to(cart_show_path)
      end
      it 'sets success flash' do
        expect(flash[:success]).to be_present
      end
    end
    context 'when some items are invalid' do
      before(:each) do
        result = {success: false, order: nil}
        allow_any_instance_of(CreateOrderService).to receive(:call).and_return(result)
        post :create
      end
      it 'assigns items' do
        expect(assigns(:items)).to eq(@cart.cart_items)
      end
      it 'render cart_show template' do
        expect(response).to render_template 'carts/show'
      end
      it 'set error flash' do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
