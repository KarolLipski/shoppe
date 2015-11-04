# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  contractor_sym  :string(255)
#  reciver_sym     :string(255)
#  email           :string(255)
#  login           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    name 'user_name'
    contractor_sym '20000068'
    reciver_sym '20000068'
    login 'user_login'
    email 'email@wp.pl'
    password 'zxczxc'
    password_confirmation 'zxczxc'
  end

end
