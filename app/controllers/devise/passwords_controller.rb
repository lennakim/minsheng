class Devise::PasswordsController < DeviseController
  prepend_before_filter :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_filter :assert_reset_token_passed, :only => :edit

  # GET /resource/password/new
  def new
    build_resource({})
  end

  # POST /resource/password
  def create
    user = User.where(resource_params).last
    if params[:type] and user
      user.touch_redirect_to = params[:type]
      self.resource = user.send_reset_password_instructions
    else
      self.resource = resource_class.send_reset_password_instructions(resource_params)
    end

    if successfully_sent?(resource)
      if params[:touch_redirect_to]
        redirect_to params[:touch_redirect_to]
      else
        respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
      end
      # respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?

      if params[:touch_redirect_to]
        redirect_to params[:touch_redirect_to]
      else
        sign_in(resource_name, resource)
        respond_with resource, :location => after_resetting_password_path_for(resource)
      end
      # respond_with resource, :location => after_resetting_password_path_for(resource)
    else
      respond_with resource
    end
  end

  protected
    def after_resetting_password_path_for(resource)
      after_sign_in_path_for(resource)
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # Check if a reset_password_token is provided in the request
    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:error, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end
end
