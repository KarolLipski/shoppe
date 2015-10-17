class MainController < ApplicationController

  def index
    @last_added = Item.active.with_photo.order(created_at: :desc).take(6)

    @recommend = Item.active.with_photo.order("RAND()").take(9)
  end

end
