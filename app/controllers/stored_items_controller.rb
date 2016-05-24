class StoredItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = find_items.order(get_sort_type).page(params[:page]).per(42)
    activate_menu_tab
  end

  private
  # Finds Items depends of type
  def find_items
    if params[:offer_id]
      return @category.offer_items.where(offer_id: params[:offer_id]).active
    end
    @category.stored_items.active
  end

  # Sets last viewed type to session (for activate proper tab)
  def activate_menu_tab
    type = (params[:offer_id]) ? 'offer': 'mag'
    session[:active_tab] = type
  end

end
