class ShopImage < ActiveRecord::Base
  attr_accessible :shop_id, :url
  belongs_to :shop
  mount_uploader :url,ShopImageUploader
end
