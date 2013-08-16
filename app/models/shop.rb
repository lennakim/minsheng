class Shop < ActiveRecord::Base
  attr_accessible :address, :phone, :title, :shopImages_attributes, :tag_list,:category_id

  has_many :shopImages

  accepts_nested_attributes_for :shopImages , :allow_destroy => true

  belongs_to :category

  has_many :taggings

  has_many :tags, through: :taggings

  has_many :rates, dependent: :destroy

  def self.tag_list
    Tag.all.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).shops
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
