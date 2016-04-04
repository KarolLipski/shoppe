require 'csv'
module CsvImporter
  class ItemsImporter
    attr_accessor :offer_id

    def import_items(file, encoding = 'windows-1250:utf-8')
      CSV.foreach(file, encoding: encoding, col_sep: ';') do |row|
        magazine = Magazine.find_by_number(row[6])
        item = update_item(row)
        update_stored(magazine, row, item)
      end
    end

    def update_stored(magazine, row, item)
      stored = StoredItem.where(magazine_id: magazine.id, item_id: item.id).first_or_create!(quantity: row[3], price: row[2].gsub(',','.'))
      stored.update(quantity: row[3], price: row[2].gsub(',','.'))
      stored
    end

    def update_item(row)
      category_id = (row[7].blank?) ? nil : row[7]
      item = Item.where(number: row[0]).first_or_create!(name: row[1], small_wrap: row[5], big_wrap: row[4], category_id: category_id)
      item.update(small_wrap: row[5], big_wrap: row[4])
      item.update_photo
      item
    end

    def actualize(file, actualization_log)
      actualization_log.update(status: 'In Progress')
      import_items(file)
      actualization_log.update(status: 'Success')
    end


  end
end