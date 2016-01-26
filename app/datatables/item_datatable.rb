class ItemDatatable < AjaxDatatablesRails::Base

  def_delegator :@view, :link_to

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w(Item.number Item.name Category.name Item.created_at Item.updated_at Item.active )
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w(Item.number Item.name)
  end


  private

  def data
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
          record.number,
          record.name,
          record.category.name,
          @view.render_date(record.created_at),
          @view.render_date(record.updated_at),
          changeActiveButton(record)
      ]
    end
  end


  def get_raw_records
    Item.joins(:category).all
  end

  def changeActiveButton(item)
    text = (item.active) ? 'Aktywny' : 'Nieaktywny'
    css = (item.active) ? "btn btn-green btn-xs" : "btn btn-red btn-xs"
    @view.link_to text, @view.admin_item_path(item, item: {active: !item.active}), remote: true, :class => css, :id => "change-active-#{item.id}" ,method: :put
  end

end
