class ApplicationController < ActionController::Base
  def user
    current_user
  end

  def method_missing meth, *args
    if meth.to_s =~ /^(.+)_only$/
      if !user.nil? and user.has_role?($1)
         true
      else
         # do a redirect, display a 401 page
         redirect_to root_path, :alert => "401"
         false
      end
    else
      super meth, args
    end
  end

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
