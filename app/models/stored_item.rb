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
#

class StoredItem < ActiveRecord::Base
  belongs_to :magazine
  belongs_to :item

  after_save :update_category_counter

  validates_presence_of :item_id , :magazine_id, :quantity, :price

  private
  # Triggers update items_count for category
  def update_category_counter
    category = item.category
    category.update_items_counter if category
  end
end
