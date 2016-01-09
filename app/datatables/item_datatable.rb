class ItemDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Item.number Item.name Item.created_at Item.category.name)
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Item.number Item.name)
  end

  def view_columns
    @view_columns ||= %w(Item.number Item.name Item.created_at Item.category.name aaa)
  end

  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
          record.number,
          record.name,
          record.created_at,
          record.category.name,
      ]
    end
  end


  def get_raw_records
    Item.includes(:category).all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
