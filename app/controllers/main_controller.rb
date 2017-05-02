# Main site controller
class MainController < ApplicationController
  layout 'frontend/amaze/root/index'

  def set_menu; end

  def index
    @last_added = StoredItem.active.order(created_at: :desc)
                            .take(30).sample(6)
    @recommend = StoredItem.active.order('RAND()').take(8)
    @bestsellers = StoredItem.bestsellers(8)
  end
end
