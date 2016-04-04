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
    @actualizations = ActualizationLog.where(log_type:'actualization').order('created_at DESC').first(3)
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

  def actualize
    file_path = save_uploaded_file(params[:file], params[:type])
    @log = ActualizationLog.create(status: 'Accepted', log_type: params[:type])
    CsvImporter::ItemsImporter.new.delay.actualize(file_path, @log)

    @actualizations = ActualizationLog.where(log_type: params[:type]).order('created_at DESC').last(3)
    @table = Time.now.strftime('%Y-%m-%d')
    redirect_to action: 'actualization'
  end

  def save_uploaded_file(file, type)
    name = "actualization#{type}_#{Time.now.to_s}"
    directory = 'public/actualizations'
    path = File.join(directory, name)
    File.open(path,'wb') { |f| f.write(file.read) }
    path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:number, :name, :small_wrap, :big_wrap, :category_id, :active)
  end

end
