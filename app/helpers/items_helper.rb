module ItemsHelper

  def render_price(item, field = :price)
    number_to_currency item.send(field) , precision: 2
  end

  #translates order type
  def sort_label(sort_type)
    case sort_type
      when 'created_at DESC'
        return 'Data: Najnowsze'
      when 'created_at ASC'
        return 'Data: Najstarsze'
      when 'price DESC'
        return 'Cena: Największa'
      when 'price ASC'
        return 'Cena: Najmniejsza'
      when 'quantity DESC'
        return 'Ilość: Największa'
      when 'quantity ASC'
        return 'Ilość: Najmniejsza'
      else
        return '--- Wybierz ---'
    end
  end

end
