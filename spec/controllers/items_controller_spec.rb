require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do
    it "assigns category" do
      category = FactoryGirl.create(:category)
      get :index, category_id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

end
