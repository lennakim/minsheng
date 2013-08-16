class Rate < ActiveRecord::Base
  attr_accessible :comment, :rank

  belongs_to :user
  belongs_to :shop

  # validates :rank, presence: true
  # validates :rank, {:greater_than 0, :less_than 6}
  # validates :comment, length: { minimum: 2, maximum: 500 }
end
