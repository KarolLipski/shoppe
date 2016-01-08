module ItemsHelper

  def render_price(item, field = :price)
    number_to_currency item.send(field) , precision: 2
  end

end
