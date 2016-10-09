class OfferItemsController < StoredItemsController

  def set_menu
    @menu = Menu::Offer.new
    @offer = Offer.active
  end

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.offer_items.where(offer_id: params[:offer_id]).active
                 .order(get_sort_type).page(params[:page]).per(42)
  end

end
