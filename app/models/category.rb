class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :name, :parent, :parent_id
  has_many :shops
  def insert(parent_id)
    if parent_id and parent_id != "" 
      # logger.info("-----------------")
      # logger.info(parent_id)
      Category.find(parent_id).children.create :name => self.name
    else
      Category.create! :name => self.name
    end

  end
end
