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
#

FactoryGirl.define do
  factory :actualization_log do
    status "Success"
    items_count 1200
    error nil
  end

end
