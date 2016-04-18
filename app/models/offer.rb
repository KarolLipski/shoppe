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

  def self.active
    now = Time.now
    where("start_date <= ? AND end_date >= ?", now, now).order(start_date: :desc).first
  end
end
