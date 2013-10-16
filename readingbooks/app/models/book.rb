class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,:desc, presence: true
end

