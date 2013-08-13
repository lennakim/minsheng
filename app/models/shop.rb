class Shop < ActiveRecord::Base
  attr_accessible :address, :phone, :title, :shopImages_attributes
  has_many :shopImages
  accepts_nested_attributes_for :shopImages , :allow_destroy => true
end
