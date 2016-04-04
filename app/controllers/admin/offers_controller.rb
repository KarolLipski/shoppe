class Admin::OffersController < AdminController

  # GET admin/offers
  def index
    @offers = Offer.all
  end

  # GET admin/offers/new
  def new
    @offer = Offer.new
  end

  # GET admin/offers/edit
  def edit
    @offer = Offer.find(params[:id])
  end

  #GET admin/offers/actualization/:offer_id
  def actualization
    @offer_id = params[:offer_id]
    @actualizations = ActualizationLog.where(log_type:'Offer').order('created_at DESC').first(1)
  end

  #POST admin/offers
  def create
    @offer = Offer.new(offer_params)
    if @offer.save
      flash[:success] = 'Oferta została dodana'
      redirect_to admin_offers_path
    else
      flash[:danger] = 'Błąd zapisu'
      render :new
    end
  end

  #PUT admin/offers/:id
  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offer_params)
      flash[:success] = 'Oferta została zmieniona'
      redirect_to admin_offers_path
    else
      flash[:danger] = 'Błąd zapisu'
      render :edit
    end
  end


  def offer_params
    params.require(:offer).permit(:name,:start_date,:end_date)
  end
end
