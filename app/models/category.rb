class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :name, :parent, :parent_id
  has_many :shops
  def insert(parent_id)
    if parent_id and parent_id != 0
      Category.find(parent_id).children.create :name => self.name
    end
  end
end
