# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  price      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items , -> { includes(:stored_item) }, inverse_of: :order

  accepts_nested_attributes_for :order_items

  validates_presence_of :user, :price
  validates_numericality_of :price, {greater_than: 0}
end
