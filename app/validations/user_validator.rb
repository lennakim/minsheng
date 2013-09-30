# encoding: utf-8

class UserValidator < ApplicationValidator
  def validate(record)
    unless record.valid_password?(record.current_password)
      record.errors[:error] << "填写旧秘密不正确"
    end
  end
end
