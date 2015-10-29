# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  login           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :user do
    name 'user_name'
    login 'user_login'
    email 'email@wp.pl'
    password 'zxczxc'
    password_confirmation 'zxczxc'
  end

end
