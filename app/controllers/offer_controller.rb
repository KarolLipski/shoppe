class OfferController < ApplicationController

  def set_menu
    @menu = MenuGenerator.new.offer_categories
  end

  def index
    @offer = Offer.find(params[:offer_id])
    @items = @offer.offer_items.active.order(get_sort_type).page(params[:page]).per(42)
  end

end
