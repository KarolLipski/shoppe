class TotalQuantityValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    return if record.item.nil? || record.send(attribute).nil?
    total = record.item.send(attribute)
    if value > total
      record.errors.add(attribute.to_sym,"nie dostępna. Maksymalna dostępna to: #{total} szt." )
    end
  end
end