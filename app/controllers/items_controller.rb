class ItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    category = Category.find(params[:category_id])
    @items = category.items
  end

end