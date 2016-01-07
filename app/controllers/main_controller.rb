class MainController < ApplicationController

  def index
    @last_added = StoredItem.active.order(created_at: :desc)
                      .take(30).shuffle.first(6)
    @recommend = StoredItem.active.order("RAND()").take(9)
  end

  def search
      @items = []
      unless params[:search].blank?
        @items = StoredItem.search(params[:search]).page(params[:page]).per(40)
      end
  end

end
