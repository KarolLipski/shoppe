class OfferItemDatatable < ItemDatatable

  attr_accessor :offer_id

  def get_raw_records
    Item.joins(:offer_items).joins("LEFT JOIN categories ON items.category_id = categories.id").where("stored_items.offer_id = ?", @offer_id).references(:offer_items)
  end

  def changeActiveButton(item)
    text = (item.active) ? 'Aktywny' : 'Nieaktywny'
    css = (item.active) ? "btn btn-green btn-xs" : "btn btn-red btn-xs"
    @view.link_to text, '#', :class => css, :id => "change-active-#{item.id}"
  end

end