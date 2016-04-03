# == Schema Information
#
# Table name: offers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Offer < ActiveRecord::Base
  has_many :offer_items
  validates_presence_of :name , :start_date, :end_date
end
