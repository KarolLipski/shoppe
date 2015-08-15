require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do
    it "assigns category" do
      category = FactoryGirl.create(:category)
      get :index, category_id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET #actualization' do

    it 'assigns last 3 actualizations' do
      actualizations =  double("actualizations");
      expect(ActualizationLog).to receive(:order).with('created_at DESC').and_return(actualizations)
      expect(actualizations).to receive(:last).with(3).and_return(actualizations)
      get :actualization
      expect(assigns(:actualizations)).to eq actualizations
    end

    it 'renders with admin layout' do
      get :actualization
      expect(response).to render_template(layout: 'admin')
    end
  end

  describe 'GET #actualize' do
    it 'creates new row in actualizationLog with Accepted status' do
      post :actualize, file: File.join(Rails.root,'test/fixtures','stany.csv')
      expect(assigns(:log).status).to eq('Accepted')
    end
    it 'renders actualiztion template' do
      post :actualize, file: File.join(Rails.root,'test/fixtures','stany.csv')
      expect(response).to render_template('actualization')
    end

  end

end
