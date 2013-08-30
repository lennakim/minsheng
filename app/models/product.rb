class Product < ActiveRecord::Base
  attr_accessible :name, :shop_id, :productImages_attributes

  belongs_to :shop

  has_many :productImages

  accepts_nested_attributes_for :productImages, :allow_destroy => true
end
