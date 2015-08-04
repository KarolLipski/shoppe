class Item < ActiveRecord::Base

  has_many :stored_items
  belongs_to :category

  validates_presence_of :name, :number, :small_wrap, :big_wrap
  validates_numericality_of :small_wrap, :big_wrap, :only_integer => true, :greater_than_or_equal_to => 0

  def price
    stored_items.max { |item_a,item_b| item_a.price <=> item_b.price}.price
  end

  def quantity
    stored_items.inject(0){ |sum, n| sum += n.quantity}
  end

end
