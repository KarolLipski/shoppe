class StoredItem < ActiveRecord::Base
  belongs_to :magazine
  belongs_to :item

  validates_presence_of :item_id , :magazine_id, :quantity, :price
end
