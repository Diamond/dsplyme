class Group < ActiveRecord::Base
  has_many :users
  has_many :projects
  has_one  :founder, class_name: "User", foreign_key: "user_id"
end
