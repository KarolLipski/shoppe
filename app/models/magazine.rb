class Magazine < ActiveRecord::Base
  validates_presence_of :number
end
