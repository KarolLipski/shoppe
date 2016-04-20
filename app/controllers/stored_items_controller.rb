class StoredItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = find_items.order(get_sort_type).page(params[:page]).per(40)
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

  # Sets last viewed type to session (for activate proper tab)
  def activate_menu_tab
    type = (params[:offer_id]) ? 'offer': 'mag'
    session[:active_tab] = type
  end

end
