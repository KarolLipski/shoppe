require 'rails_helper'

RSpec.describe CartsController, type: :controller do

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

  describe 'POST add_item' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      @cart = current_cart
      @stored_item = FactoryGirl.create(:stored_item)
      @item = @stored_item.item
    end
    it 'assigns current cart' do
      xhr :post, :add_item, item_id: @item.id, quantity: 2
      expect(assigns(:cart).user_id).to eq @user.id
    end
    context 'when data is valid' do
      it 'creates new cart_item' do
        xhr :post, :add_item, item_id: @item.id, quantity: 2
        expect(assigns(:cart_item).item_id).to eq @item.id
      end
      it 'renders save template' do
        xhr :post, :add_item, item_id: @item.id, quantity: 2
        expect(response).to render_template('save')
      end
      context 'and item is already present in cart' do
        it 'change quantity to current value' do
          @cart.cart_items.create(quantity: 10, item: @item)
          xhr :post, :add_item, item_id: @item.id, quantity: 2
          expect(@cart.cart_items.length).to eq 1
          expect(@cart.cart_items.first.quantity).to eq 2
        end
      end
    end
    context 'when data is invalid' do
      it 'doesnt create cart_item' do
        xhr :post, :add_item, item_id: @item.id, quantity: 'abc'
        expect(@cart.cart_items.length).to eq 0
      end
      it 'assigns errors messages' do
        xhr :post, :add_item, item_id: @item.id, quantity: 'abc'
        expect(assigns(:errors).size).to eq 1
      end
      it 'renders save template' do
        xhr :post, :add_item, item_id: @item.id, quantity: 'abc'
        expect(response).to render_template('save')
      end
    end
    context 'when user is not logged' do
      it 'sets error message' do
        log_out
        xhr :post, :add_item, item_id: @item.id, quantity: '23'
        expect(assigns(:errors).size).to eq 1
      end
    end
  end

end
