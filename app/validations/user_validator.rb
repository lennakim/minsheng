# encoding: utf-8

class UserValidator < ApplicationValidator
  def validate(record)
    Rails.logger.debug{ 'aaaaaaaaaaabbb' }
    unless record.valid_password?(record.current_password)
      record.errors[:error] << "填写旧秘密不正确"
    end
  end
end

module ClientSideValidations::Middleware
  class User < ClientSideValidations::Middleware::Base
    def response
      Rails.logger.debug{ 'aaaaaaaaaaa' }
      if ::User.where(:id => request.params[:id]).exists?
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end
