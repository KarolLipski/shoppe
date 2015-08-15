# == Schema Information
#
# Table name: actualization_logs
#
#  id          :integer          not null, primary key
#  status      :string
#  items_count :integer
#  error       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ActualizationLog < ActiveRecord::Base
  validates_presence_of :status
end
