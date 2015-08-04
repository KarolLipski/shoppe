class Magazine < ActiveRecord::Base

  has_many :stored_items

  validates_presence_of :number
end
