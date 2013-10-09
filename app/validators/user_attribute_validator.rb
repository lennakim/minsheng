# encoding: utf-8

class UserAttributeValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)

  end
end

module ClientSideValidations::Middleware
  class UserAttribute < ClientSideValidations::Middleware::Base
    def response
      if request.params[:attr_name] == 'mobile'
        mobile = request.params[:mobile]
        if mobile.blank?
          st = 404
        else
          if mobile =~ /\A1\d{10}\Z/
            st = ::User.find_by_mobile(mobile).nil? ? 200 : 404
          else
            st = 404
          end
        end
      elsif request.params[:attr_name] == 'email'
        email = request.params[:email]
        if email.blank?
          st = 404
        else
          if email =~ /^[^@\s]+@([^@\s]+\.)+[^@\s]+$/
            st = ::User.find_by_email(email).nil? ? 200 : 404
          else
            st = 404
          end
        end
      elsif request.params[:attr_name] == 'reset_password'
        st = ::User.find(request.params[:user_id].to_i).
          valid_password?(request.params[:current_password]) ? 200 : 404
      end
      self.status = st
      super
    end
  end
end
