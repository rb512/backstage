class Restaurant < ActiveRecord::Base
  belongs_to :owner
  attr_accessible :address, :city, :country, :email, :menu_id, :name, :owner_id, :phone, :state, :zip
  
  validates_presence_of :address, :city, :country, :email, :name, :phone, :state, :zip
end
