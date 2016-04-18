class AdminController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  layout 'admin'

  before_action :authenticate

  def authenticate
    redirect_to root_url unless logged_admin?
  end

end
