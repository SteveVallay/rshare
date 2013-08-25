class Post < ActiveRecord::Base
  validates :title,:text,:origin_name,:real_name,presence:true
end
