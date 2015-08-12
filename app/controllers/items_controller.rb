class ItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items.active.page(params[:page]).per(25)
  end

  # get /items/actualization
  def actualization
    importer = CsvImporter::ItemsImporter.new
   # @print = importer.import_items(File.join(Rails.root,'tmp','stany.csv'))
  end

  def actualize
    @table = Time.now.strftime('%Y-%m-%d')
    render 'actualization'
  end

end
