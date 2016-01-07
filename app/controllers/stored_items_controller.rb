class StoredItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.stored_items.active.page(params[:page]).per(40)
  end
end
