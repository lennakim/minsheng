# encoding: utf-8

class Notice < ActiveRecord::Base
  attr_accessible :content, :tag_type, :title

  TAG_TYPE = { '前' => 1, '后' => 2, '左' => 3, '右' => 4 }
end
