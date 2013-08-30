class ProductImage < ActiveRecord::Base
  attr_accessible :product_id, :url
  belongs_to :product
  mount_uploader :url, ProductImageUploader
end
