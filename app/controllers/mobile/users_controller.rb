#encoding: utf-8
class Mobile::UsersController < ApplicationController
  layout 'mobile'

  def email_sign_up
    #TODO if user login redirect_to home
    # @user = User.new
  end

  def phone_sign_up
    #TODO if user login redirect_to home
    # @user = User.new
  end

  def create
    user = User.new(params[:user])
    captcha_code = params[:captcha_code]

    unless is_mobile_exist?(user.mobile)
      verification = Verification.last_verification(user.mobile)
      if verification
        if verification.mobile_captcha_code.downcase == captcha_code.downcase
          user.email = verification.temp_email
          user.is_auth_for_mobile = true
          user.save
          sign_in(:user, user)
          redirect_to root_url
        end
      end
    else
      redirect_to mobile_users_sign_up_url
    end
  end

  def send_sms
    status, message = false, ""
    mobile = params[:mobile]

    unless is_mobile_exist?(mobile)
      captcha_code = Verification.generate_captcha_code
      content = generate_sms_content(mobile,captcha_code)
      temp_email = generate_temp_email(mobile)

      result = Sms.send_message_by_smsbao(mobile,content)
      if result[:success]
        v = Verification.new(:mobile_captcha_code => captcha_code, :mobile_last_sent_at => Time.now, :mobile => mobile,:temp_email => temp_email )
        v.save

        status, message = true, "短信发送成功"
      else
        status, message = false, "短信未发送成功"
      end
    else
      status, message = true, "此手机已经注册"
    end
    render :json => { :status => status, :message => message }
  end


  def verify_mobile
    captcha_code = params[:captcha_code]
    mobile = params[:mobile]
    verification = Verification.last_verification(mobile)

    if verification

      unless Verification.is_lt_expire_time?(verification.mobile_last_sent_at)
        result, message = false, "时间已经过期"
      else
        if verification.mobile_captcha_code.downcase == captcha_code.downcase
          temp_email = generate_temp_email(mobile)
          verification.update_attributes(:is_auth_for_mobile => true,:temp_email => temp_email)

          result, message = true, "绑定手机成功"
        else
          result, message = false, "验证码错误"
        end
      end
    else
      result, message = false, "手机号码不存在"
    end
    render :json => { :status => result, :message => message }
  end

  def reset_password_page

  end

  def send_password_token
    mobile = params[:mobile].to_i
    user = User.find_by_mobile(mobile)
    message = ""

    if user
      password_token = User.generate_password_token
      content = generate_reset_password_content(mobile,password_token)
      result = Sms.send_message_by_smsbao(mobile,content)

      if result[:success]
        user.update_attributes(:reset_password_token_for_mobile => password_token, :reset_password_sent_at_for_mobile => Time.now)
        message = "发送成功"
      else
        message = "发送失败"
      end
    else
      message = "此号码不存在"
    end

    render :json => { :message => message }
  end

  def reset_password
    mobile = params[:mobile].to_i
    token = params[:token]
    message = ""

    user = User.where(:reset_password_token_for_mobile => token, :mobile=>mobile).first

    if user
      user.password = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.reset_password_token_for_mobile = nil
      user.reset_password_sent_at_for_mobile = nil
      user.save
      sign_in(:user, user)
      message = "修改成功"
    else
      message = "无效的"
    end

    redirect_to root_url, :flash => { :notice => message }
  end


  def retrieve_all

  end

  def send_reset_password_token
    mobile = params[:mobile]
    user = User.find_by_mobile(mobile)

    uid, action_name, message = "", "", ""

    if user
      password_token = User.generate_password_token
      content = generate_reset_password_content(mobile,password_token)
      result = Sms.send_message_by_smsbao(mobile,content)

      if result[:success]
        user.update_attributes(:reset_password_token_for_mobile => password_token, :reset_password_sent_at_for_mobile => Time.now)
        uid = user.id
        action_name, message = "retrieve_phone_step_one", "发送成功"
      else
        action_name, message = "retrieve_all", "发送失败"
      end
    else
      action_name, message = "retrieve_all", "不存在"
    end

    redirect_to :action => action_name, :id => uid, :notice => message
  end

  def retrieve_phone_step_one
    @id = params[:id]
  end

  def phone_verify_password_token
    id = params[:id]
    captcha_code = params[:captcha_code]
    #验证手机 是否匹配
    user = User.find(id)

    if captcha_code.downcase == user.reset_password_token_for_mobile.downcase
      redirect_to :action => "retrieve_phone_step_two", :id => id
    else
      redirect_to :action => "retrieve_phone_step_one", :id => id
    end
  end

  def retrieve_phone_step_two
    @user = User.find params[:id]
  end

  def phone_reset_user_password
    user = User.find(params[:user][:id])

    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    user.reset_password_token_for_mobile = nil
    user.reset_password_sent_at_for_mobile = nil
    user.save

    redirect_to :action => "phone_reset_password_succcess"
  end

  def phone_reset_password_succcess

  end

  private

  def generate_sms_content(phone,captcha_code)

    # content = <<-EOF
    #   您的手机号码是: #{phone},验证码是: #{captcha_code},请在一天内注册.
    #   如果不是您本人的操作,请忽略此条短信.
    # EOF

  end

  def generate_reset_password_content(mobile, token)

    # content = <<-EOF
    #   您的手机号码是: #{mobile},重置验证码是: #{token}.
    #   如果不是您本人的操作,请忽略此条短信.
    # EOF

  end

  def generate_temp_email(phone)
    phone.to_s + "@temp.com"
  end

  def is_mobile_exist?(mobile)
    User.find_by_mobile(mobile).nil? ? false : true
  end

end
