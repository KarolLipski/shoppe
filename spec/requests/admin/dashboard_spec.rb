require 'rails_helper'

RSpec.describe "Dashboard", :type => :request do

    context 'When user autorized' do
        before :each do
            allow_any_instance_of(AdminController).to receive(:authenticate)
        end
        it 'Http status should by 200' do
            get '/admin/'
            expect(response).to have_http_status(200)
        end
        it 'render main template' do
            get '/admin/'
            expect(response).to render_template(:main)
        end
    end
    context 'When user is not authorized' do
        it 'Redirects to main page' do
            get '/admin/'
            expect(response).to redirect_to('/')
        end
    end

end