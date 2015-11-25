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

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  has_one :cart

  before_validation :downcase_email

  validates_presence_of :name, :login, :contractor_sym, :reciver_sym
  validates_format_of :email, with: VALID_EMAIL_REGEX, allow_blank: true
  validate :password_unique?

  # Legacy code allows many same logins for one customer with different password
  def password_unique?
    users = User.where(login: login)
    if users.any?
      users.each do |u|
        errors.add(:password,'Login i hasło jest już w systemie') if u.authenticate(password)
      end
    end
  end

  def downcase_email
    self.email = email.downcase if self.email
  end
end
