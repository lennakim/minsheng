class Favor < ActiveRecord::Base
  attr_accessible :shop_id, :user_id
  belongs_to :shop
  belongs_to :user
end
