class Mobile::PasswordController < Devise::PasswordsController
layout 'mobile'
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      redirect_to mobile_users_sign_in_path
    else
      redirect_to mobile_users_retrieve_all_path
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_resetting_password_path_for(resource)
    else
      respond_with resource
    end
  end

  def retrieve_email_step_one
    @reset_password_token = params[:reset_password_token]
  end

  def retrieve_email_step_two

  end

end
