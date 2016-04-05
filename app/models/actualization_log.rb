# == Schema Information
#
# Table name: actualization_logs
#
#  id          :integer          not null, primary key
#  status      :string(255)
#  items_count :integer
#  error       :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  log_type    :string(255)
#

class ActualizationLog < ActiveRecord::Base
  validates_presence_of :status, :log_type
end
