class MainController < ApplicationController

  layout 'frontend/amaze/root/index'

  def index
    @last_added = StoredItem.active.order(created_at: :desc)
                      .take(30).shuffle.first(6)
    @recommend = StoredItem.active.order("RAND()").take(8)
    @bestsellers = StoredItem.bestsellers(8)
  end

end
