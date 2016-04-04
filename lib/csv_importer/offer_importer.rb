require 'csv'
module CsvImporter
  class OfferImporter < ItemsImporter
    attr_accessor :offer_id

    def import_items(file, encoding = 'windows-1250:utf-8')
      CSV.foreach(file, encoding: encoding, col_sep: ';') do |row|
        item = update_item(row)
        update_stored(nil,row, item)
      end
    end

    def update_stored(magazine, row, item)
      stored = OfferItem.where(offer_id: @offer_id, item_id: item.id).first_or_create!(price: row[2].gsub(',','.'))
      stored.update(price: row[2].gsub(',','.'))
      stored
    end

    def update_item(row)
      category_id = (row[5].blank?) ? nil : row[5]
      item = Item.where(number: row[0]).first_or_create!(name: row[1], small_wrap: row[4], big_wrap: row[3], category_id: category_id)
      item.update_photo
      item
    end
  end
end