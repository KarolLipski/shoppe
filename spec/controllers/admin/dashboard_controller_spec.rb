require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  before :each do
    allow_any_instance_of(AdminController).to receive(:authenticate)
  end

  describe "GET #main" do
    it "returns http success" do
      get :main
      expect(response).to have_http_status(:success)
    end
  end

end
