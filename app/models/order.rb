class Order < ActiveRecord::Base
  attr_accessible :restaurant_id, :server_id, :table_id, :total, :user_id
end
