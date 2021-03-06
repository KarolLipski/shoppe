require 'rails_helper'

RSpec.describe CartsController, type: :controller do

  describe 'GET Init_add' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      log_in(@user)
      @stored_item = FactoryGirl.create(:stored_item)
      xhr :get, :init_add, item_id: @stored_item.id
    end
    it 'assigns item' do
      expect(assigns(:item)).to eq(@stored_item)
    end
    it 'assigns current_cart' do
      expect(assigns(:current_cart).user_id).to eq @user.id
    end
    it 'renders init_add template' do
      expect(response).to render_template('init_add')
    end
  end



end
