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

class OfferItem < StoredItem
  belongs_to :offer
  after_save :update_category_counter

  scope :active, -> { includes(:item).select('MAX(stored_items.id) as id',
                                             'quantity', 'item_id','price',
                                             'created_at',
                                             'updated_at').
      where('items.photo is not null and items.active = 1').group(:item_id).references(:item) }

  validates_presence_of :item_id , :price

  # Max price from all magazines
  def sell_price
    price
  end
  # Sum quantities from all magazines
  def sell_quantity
    100000000000
  end

  #After buy we dont remove quantities
  def pick_form_magazine(quantity)

  end

  private
  # Triggers update items_count for category
  def update_category_counter
  end
end
