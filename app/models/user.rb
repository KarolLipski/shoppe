class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password
  validates_presence_of :name, :login
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_uniqueness_of :login, :email

  before_validation :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
