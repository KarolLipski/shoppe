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

FactoryGirl.define do
  factory :actualization_log do
    status "Success"
    items_count 1200
    error nil
  end

end
