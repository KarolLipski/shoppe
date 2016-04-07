class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_menu

  include SessionsHelper

  def set_menu
    @categories = Category.main.order(:name)
    offer_categories = Category.all_for_offer(4)
    offer_cat_ids = []
    offer_categories.each do |cat|
      offer_cat_ids << cat.id
      offer_cat_ids << cat.parent_id if cat.parent_id
    end
    @offer_categories = offer_cat_ids.to_set
  end

end
