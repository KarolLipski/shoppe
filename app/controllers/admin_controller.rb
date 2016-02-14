class AdminController < ApplicationController
  include SessionsHelper

  layout 'admin'

  before_action :authenticate

  def authenticate
    redirect_to root_url unless logged_admin?
  end

end
