class ItemsController < ApplicationController

  def index
    @items = StoredItem.active.order(get_sort_type).page(params[:page]).per(42)
  end

end
