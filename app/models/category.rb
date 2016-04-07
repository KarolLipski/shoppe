# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  items_count :integer          default(0)
#

class Category < ActiveRecord::Base

  has_many :items
  has_many :stored_items, through: :items
  has_many :offer_items, through: :items

  has_many :subcategories, :class_name => 'Category', :foreign_key => "parent_id"
  belongs_to :parent , :class_name => 'Category'
  
  validates_presence_of :name

  #Returns Root categories
  def self.main
    all.where(parent: nil)
  end

  #Counts items from category
  def count_items
    StoredItem.joins(:item).
        select("items.id").distinct.
        where(["items.category_id = :category_id AND stored_items.quantity > :quantity
        AND items.photo is not null AND items.active",
               {category_id: id, quantity: 0}]).
        count
  end

  #updates items_counter
  def update_items_counter
    count =  count_items
    if(items_count != count)
      update(items_count: count)
      update_parent_counter
    end
  end

  #updates parent Category counter
  def update_parent_counter
    if parent_category = parent
      count = Category.where(parent_id: parent_id).sum(:items_count)
      parent_category.update(items_count: count)
    end
  end

  def self.all_for_offer(offer_id)
    includes(:parent).where('id IN (SELECT DISTINCT items.category_id FROM items join stored_items where stored_items.offer_id = 4)')
  end


end
