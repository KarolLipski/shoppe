class MainController < ApplicationController

  def index
    @last_added = Item.active.with_photo.order(created_at: :desc)
                      .take(30).shuffle.first(6)
    @recommend = Item.active.with_photo.order("RAND()").take(9)
  end

  def search
      @items = []
      unless params[:search].blank?
        @items = Item.active.with_photo.search(params[:search]).page(params[:page]).per(40)
      end
  end

end
