class ItemsController < ApplicationController

  layout 'admin', only: [:actualization, :actualize]

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items.active.page(params[:page]).per(25)
  end

  # get /items/actualization
  def actualization
    @actualizations = ActualizationLog.order('created_at DESC').last(3)
  end

  def actualize
    importer = CsvImporter::ItemsImporter.new
    @log = ActualizationLog.create(status: 'Accepted')
    @actualizations = ActualizationLog.order('created_at DESC').last(3)
    @table = Time.now.strftime('%Y-%m-%d')
    render 'actualization'
  end

end
