class TotalQuantityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if record.stored_item.nil? || record.send(attribute).nil?
    total = record.stored_item.send(:sell_quantity)
    if value > total
      record.errors.add(attribute.to_sym,"nie dostępna. Maksymalna dostępna to: #{total} szt." )
    end
  end
end