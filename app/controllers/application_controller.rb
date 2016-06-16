class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_menu

  layout 'amaze'

  include SessionsHelper

  def set_menu
    @offer = Offer.active
    @menu = MenuGenerator.new.magazine_categories
  end

  # Gets customer ordering
  def get_sort_type
    sort, sort_type = 'created_at','DESC'
    if params[:sort]
      sort = params[:sort] ? params[:sort] : sort
      sort_type = params[:sort_type] ? params[:sort_type] : sort_type
    elsif session[:customer_sort_type]
      return @sort_type = session[:customer_sort_type]
    end
    return session[:customer_sort_type] = @sort_type = "#{sort} #{sort_type}"
  end

end
