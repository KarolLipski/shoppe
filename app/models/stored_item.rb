# == Schema Information
#
# Table name: stored_items
#
#  id          :integer          not null, primary key
#  magazine_id :integer
#  item_id     :integer
#  quantity    :integer
#  price       :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string(255)
#  offer_id    :integer
#

class StoredItem < ActiveRecord::Base
  belongs_to :magazine
  belongs_to :item

  delegate :photo,:name,:number,:small_wrap,:big_wrap,:barcode, to: :item

  after_save :update_category_counter


  scope :active, -> { includes(:item).select('MAX(stored_items.id) as id',
         'SUM(quantity) as quantity', 'item_id','MAX(price) as price',
         'MAX(stored_items.created_at) as created_at',
         'MAX(stored_items.updated_at) as updated_at').
          where('items.photo is not null and items.active = 1').group(:item_id).
          having('SUM(stored_items.quantity) > 0').references(:item) }

  validates_presence_of :item_id , :price
  validates_presence_of :magazine_id, :quantity, if: :check_base

  def check_base
    self.class == StoredItem
  end
  # Max price from all magazines
  def sell_price
    StoredItem.select('MAX(price) as max_price').where(item: item).first.max_price
  end
  # Sum quantities from all magazines
  def sell_quantity
    StoredItem.select('SUM(quantity) as sum_quantity').where(item: item).first.sum_quantity
  end
  # simple search by number or name
  def self.search(query)
    active.where("number LIKE ? or name LIKE ? or barcode LIKE ?",
          "%#{query}%","%#{query}%", "%#{query}%").order(created_at: :desc)
  end

  private
  # Triggers update items_count for category
  def update_category_counter
    category = item.category
    category.update_items_counter if category
  end
end
