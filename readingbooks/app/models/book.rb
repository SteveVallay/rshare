class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,:desc,:md5,:location, presence: true
end

