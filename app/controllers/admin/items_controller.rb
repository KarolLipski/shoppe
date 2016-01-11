class Admin::ItemsController < AdminController

  skip_before_filter :verify_authenticity_token, only: [:update]

  # list of all items
  def index
    respond_to do |format|
      format.html
      format.json { render json: ItemDatatable.new(view_context)}
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
      else
        format.json do
          render json: { errors: @item.errors.full_messages}
        end
      end
    end
  end

  # get /items/actualization
  def actualization
    @actualizations = ActualizationLog.order('created_at DESC').first(3)
  end

  #get /items/noCategories
  def no_categories
    @categories = Category.main.order(:name)
    @items = Item.active.with_photo.where(category: nil).order('number DESC')
  end

  def actualize
    file_path = save_uploaded_file params[:file]
    @log = ActualizationLog.create(status: 'Accepted')
    CsvImporter::ItemsImporter.new.delay.actualize(file_path, @log)

    @actualizations = ActualizationLog.order('created_at DESC').last(3)
    @table = Time.now.strftime('%Y-%m-%d')
    redirect_to action: 'actualization'
  end

  def save_uploaded_file(file)
    name = "actualization#{Digest::MD5.hexdigest(Time.now.to_s)}"
    directory = 'public/actualizations'
    path = File.join(directory, name)
    File.open(path,'wb') { |f| f.write(file.read) }
    path
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:number, :name, :small_wrap, :big_wrap, :category_id)
  end

end
