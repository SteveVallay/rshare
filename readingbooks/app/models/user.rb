require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :books
  validates :name, :email, presence: true, uniqueness: true
  validates :name, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }

  def self.auth(email, pass)
    user = find_by_email(email)
    if user && user.password == pass
      user
    else
      nil
    end
  end

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def admin?
    self.admin
  end

end
