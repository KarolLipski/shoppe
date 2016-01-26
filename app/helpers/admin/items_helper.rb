module Admin::ItemsHelper
  def changeActiveButton(item)
    if(item.active)
      text = 'Aktywny'
      css = "btn btn-green btn-xs"
      active_to = 0
    else
      text = 'Nieaktywny'
      css = "btn btn-red btn-xs"
      active_to = 1
    end
    link_to text, admin_item_path(item, item: {active: active_to}), remote: true, :class => css, :id => "change-active-#{item.id}" ,method: :put
  end
end
