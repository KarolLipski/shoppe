class Admin::OffersController < AdminController

  # GET admin/offers
  def index
    @offers = Offer.all
  end
end
