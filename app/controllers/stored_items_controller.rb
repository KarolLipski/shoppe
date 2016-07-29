class StoredItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.stored_items.active.order(get_sort_type)
                 .page(params[:page]).per(42)

  end

  def search
    @items = []
    unless params[:search].blank?
      @items = StoredItem.search(params[:search]).order(get_sort_type).page(params[:page]).per(42)
    end
  end

end
