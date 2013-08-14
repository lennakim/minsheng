# encoding: utf-8

class Notice < ActiveRecord::Base
  attr_accessible :content, :tag_type, :title, :issue_time

  validates :content, :tag_type, :title, :issue_time, presence: true

  TAG_TYPE = { '前' => 1, '后' => 2, '左' => 3, '右' => 4 }

  def format_date(format_str = '%Y-%m-%d %H:%M:%S')
    issue_time.nil? ? nil : issue_time.strftime(format_str)
  end

  def tag_text
    tag_type.nil? ? nil : TAG_TYPE.key(tag_type.to_i)
  end
end
