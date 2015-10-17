# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base

  has_many :items

  has_many :subcategories, :class_name => 'Category', :foreign_key => "parent_id"
  belongs_to :parent , :class_name => 'Category'
  
  validates_presence_of :name

  def self.main
    all.where(parent: nil)
  end
end
