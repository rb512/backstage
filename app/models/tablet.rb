class Tablet < ActiveRecord::Base
  belongs_to :owner
  
  attr_accessible :ip_address, :is_server, :owner_id, :restaurant_id, :serial_no
  
  validates :serial_no, :uniqueness => true
end
