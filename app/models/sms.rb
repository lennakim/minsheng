# encoding: utf-8
require 'net/http'
require 'digest'
require "china_sms"

class Sms

  USERNAME = "shooter" # Please provide one username
  PASSWORD = "199011024410" # Please provide one password

  def self.send_message_by_smsbao(*phone,content)
    ChinaSMS.use :smsbao, username: USERNAME, password: PASSWORD
    ChinaSMS.to phone, content
  end
end
