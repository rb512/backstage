class LineItems < ActiveRecord::Base
  attr_accessible :item_name, :item_price, :menu_item_id, :order_id
end
