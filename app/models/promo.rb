class Promo < ActiveRecord::Base
  attr_accessible :content, :description, :end_date, :mobile_image, :shop_id, :web_image
  belongs_to :shop
  
  mount_uploader :mobile_image, PromoImageUploader
  mount_uploader :web_image, PromoImageUploader
end
