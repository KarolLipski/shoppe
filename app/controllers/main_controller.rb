# Main site controller
class MainController < ApplicationController
  layout 'frontend/amaze/root/index'

  def set_menu; end

  def index
    @last_added = Reco::Engine.last_added(30, 6)
    @recommend = Reco::Engine.reccomend(8)
    @bestsellers = Reco::Engine.bestsellers(8)
  end
end
