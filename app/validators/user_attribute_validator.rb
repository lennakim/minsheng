# encoding: utf-8

class UserAttributeValidator < ActiveModel::EachValidator
end

module ClientSideValidations::Middleware
  class UserAttribute < ClientSideValidations::Middleware::Base
    def response
      self.status = ::User.find(request.params[:user_id].to_i).
        valid_password?(request.params[:current_password]) ? 200 : 404
      super
    end
  end
end
