class ItemsController < ApplicationController

  # GET /categories/:category_id/items
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items.active.page(params[:page]).per(25)
  end

  def actualization
    importer = ItemsImporter.new
    @print = importer.import_items(File.join(Rails.root,'tmp','stany.csv'))
  end

end
