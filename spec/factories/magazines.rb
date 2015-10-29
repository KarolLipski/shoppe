# == Schema Information
#
# Table name: magazines
#
#  id         :integer          not null, primary key
#  number     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :magazine do
    number "5016"
  end

end
