class Category < ActiveRecord::Base

  has_many :items

  has_many :subcategories, :class_name => 'Category', :foreign_key => "parent_id"
  belongs_to :parent , :class_name => 'Category'
  
  validates_presence_of :name

  def self.main
    all.where(parent: nil)
  end
end
