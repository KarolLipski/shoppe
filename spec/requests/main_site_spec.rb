require "rails_helper"

RSpec.describe "Main site", :type => :request do
    it 'http status should by 200' do
        get "/"
        expect(response).to have_http_status(200)
    end
    it 'render main view' do
        get "/"
        expect(response).to render_template(:index)
    end
end