class Devise::OmniauthCallbacksController < DeviseController
  prepend_before_filter { request.env["devise.skip_timeout"] = true }
  def doorkeeper
    oauth_data = request.env["omniauth.auth"]
    # p oauth_data
    @user = User.find_or_create_for_doorkeeper_oauth(oauth_data)
    if @user
        sign_in_and_redirect @user
        return
    else
        render :status => 404, :text => "Not found. Authentication passthru."
    end
  end

  def passthru
    render :status => 404, :text => "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, :kind => OmniAuth::Utils.camelize(failed_strategy.name), :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
end
