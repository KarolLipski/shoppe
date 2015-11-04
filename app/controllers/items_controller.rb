class ItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items.active.with_photo.order(created_at: :desc).page(params[:page]).per(40)
  end


end
