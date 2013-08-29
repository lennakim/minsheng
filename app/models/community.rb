class Community < ActiveRecord::Base
  attr_accessible :address, :description, :name

  belongs_to :district
end
