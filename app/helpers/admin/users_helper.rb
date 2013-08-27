# encoding: utf-8
module Admin::UsersHelper
  def view_role role
    case role
    when "admin"
      "超级管理员"
    when "editor"
      "编辑"
    else
      "游客"
    end
  end
end
