class Notification < ActiveRecord::Base
  attr_accessible :sender, :content, :is_read, :receiver, :title
end
