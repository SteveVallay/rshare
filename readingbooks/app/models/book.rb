class Book < ActiveRecord::Base
  belongs_to :user
  validates :name,:desc,:md5,:location, presence: true
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ? or desc LIKE ?',"%#{search}%","%#{search}%"])
    else
      find(:all)
    end
  end
end

