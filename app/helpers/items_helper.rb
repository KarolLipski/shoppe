module ItemsHelper

  def render_price(item)
    number_to_currency item.price , precision: 2
  end

end
