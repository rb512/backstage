class Employee < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :owner
  
  mount_uploader :avatar, AvatarUploader
  attr_accessible :avatar, :category, :email, :feedback_score, :name, :owner_id, :phone, :restaurant_id, :avatar
end
