class Notification < ActiveRecord::Base
  attr_accessible :sender, :content, :expire_at, :is_read, :receiver, :title
end
