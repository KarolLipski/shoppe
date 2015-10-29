# == Schema Information
#
# Table name: magazines
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Magazine < ActiveRecord::Base

  has_many :stored_items

  validates_presence_of :number
end
