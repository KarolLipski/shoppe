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

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates_presence_of :name, :login
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true
  # validates_uniqueness_of :login
  validates_uniqueness_of :email, allow_blank: true


  before_validation :downcase_email

  def downcase_email
    self.email = email.downcase if self.email
  end
end
