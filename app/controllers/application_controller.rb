class ApplicationController < ActionController::Base
  layout false

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
  def doorkeeper_oauth_client 
    @client ||= OAuth2::Client.new(DOORKEEPER_APP_ID, DOORKEEPER_APP_SECRET, :site => DOORKEEPER_APP_URL)
  end 

  def doorkeeper_access_token 
    @token ||= OAuth2::AccessToken.new(doorkeeper_oauth_client, current_user.doorkeeper_access_token) if current_user
  end 

end
