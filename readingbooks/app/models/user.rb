class User < ActiveRecord::Base
  has_many :books
  validates :name, :email, presence: true
end
