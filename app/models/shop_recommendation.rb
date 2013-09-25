# encoding: utf-8

class ShopRecommendation < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :end_time, :shop_id, :start_time, :flag_type, :sort

  # relationships .............................................................
  belongs_to :shop

  # constants definition ......................................................
  FLAG_TYPE = { '前' => 1, '后' => 2, '左' => 3, '右' => 4 }

  # validations ...............................................................
  validates :shop_id, :flag_type, :start_time, :end_time, :sort, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................
  def flag_text
    flag_type.nil? ? nil : FLAG_TYPE.key(flag_type.to_i)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end