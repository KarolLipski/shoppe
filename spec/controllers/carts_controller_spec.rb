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
      @item = FactoryGirl.create(:item)
    end
    it 'assigns current cart' do
      expect(assigns(:current_cart).user_id).to eq @user.id
    end
    context 'when data is valid' do
      it 'creates new cart_item' do

      end
      it 'renders save template' do

      end
      it 'assigns success flash' do

      end
      context 'and item is already present in cart' do
        it 'change quantity to current value' do

        end
      end
    end
    context 'when data is invalid' do
      it 'doesnt create cart_item' do

      end
      it 'assigns errors messages' do

      end
      it 'renders save template' do

      end
    end
  end

end
