class ProductImage < ActiveRecord::Base
  attr_accessible :product_id, :image
  belongs_to :product
  mount_uploader :image, ProductImageUploader

end
