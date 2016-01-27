class ItemDatatable < AjaxDatatablesRails::Base

  attr_accessor :context

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
    return all_context unless @context
    self.send("#{@context}_context".to_sym)
  end

  # All items
  def all_context
    Item.joins(:category).all
  end

  # Active Items without photo
  def no_photo_context
    Item.joins(:stored_items).joins(:category).where('active = 1')
        .where('photo IS NULL')
        .where('stored_items.quantity > 0')
        .references(:stored_items)
  end

  def changeActiveButton(item)
    text = (item.active) ? 'Aktywny' : 'Nieaktywny'
    css = (item.active) ? "btn btn-green btn-xs" : "btn btn-red btn-xs"
    @view.link_to text, @view.admin_item_path(item, item: {active: !item.active}), remote: true, :class => css, :id => "change-active-#{item.id}" ,method: :put
  end

end
