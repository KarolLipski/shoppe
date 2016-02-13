class AdminController < ApplicationController
  include SessionsHelper
  layout 'admin'

  before_action :authenticate

  def authenticate
    redirect_to root_url unless (logged_in? && current_user.admin?)
  end

end
