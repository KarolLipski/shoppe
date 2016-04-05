class Admin::ItemsController < AdminController

  skip_before_filter :verify_authenticity_token, only: [:update]

  # list of all items
  def index
    datatable = ItemDatatable.new(view_context)
    respond_to do |format|
      format.html
      format.json { render json: datatable}
    end
  end

  # PATCH/PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    respond_to do |format|
      if @item.update(item_params)
        @item.category.update_items_counter if @item.category
        format.json  do
          render json: {errors: nil}
        end
        format.js do
          render :changeActive
        end
      else
        format.json do
          render json: { errors: @item.errors.full_messages}
        end
      end
    end
  end

  # get /items/actualization
  def actualization
    @actualizations = ActualizationLog.where(log_type:'Items').order('created_at DESC').first(3)
  end

  #get /items/noCategories
  def no_categories
    @categories = Category.main.order(:name)
    @items = Item.on_stock.with_photo.where(category: nil).order('number DESC')
  end

  #GET /items/noPhotos
  def no_photos
    datatable = ItemDatatable.new(view_context)
    datatable.context = 'no_photo'
    respond_to do |format|
      format.html
      format.json { render json: datatable}
    end
  end

  #POST /items/actualize
  def actualize
    @actualizator = ItemActualizator.new(params)

    unless params.has_key?(:file)
      @actualizations = ActualizationLog.where(log_type: params[:type]).
          order('created_at DESC').last(@actualizator.log_count)
      flash[:danger] = 'Nie wybrano pliku Csv'
      return redirect_to @actualizator.redirect
    end
    @actualizator.actualize_from_csv
    flash[:success] = 'Plik CSV zostanie wgrany w tle'
    redirect_to @actualizator.redirect
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:number, :name, :small_wrap, :big_wrap, :category_id, :active)
  end

end
