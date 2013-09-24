# encoding: utf-8
class MobileController < ApplicationController

  def sign_up
    @user = User.new
  end

  def create
    user = User.new(params[:user])

    unless is_mobile_exist?(user.mobile)
      verification = Verification.last_verification(user.mobile)
      if verification
        if verification.is_auth_for_mobile
          user.email = verification.temp_email
          user.is_auth_for_mobile = true
          user.save
          sign_in(:user, user)
          redirect_to root_url
        end
      end
    else
      redirect_to mobile_sign_up_path
    end
  end

  def send_sms
    status, message = false, ""
    mobile = params[:mobile]

    unless is_mobile_exist?(mobile)
      captcha_code = Verification.generate_captcha_code
      content = generate_sms_content(mobile,captcha_code)

      result = Sms.send_message_by_smsbao(mobile,content)
      if result[:success]
        v = Verification.new(:mobile_captcha_code => captcha_code, :mobile_last_sent_at => Time.now, :mobile => mobile)
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

private

  def generate_sms_content(phone,captcha_code)
    content = <<-EOF
      您的手机号码是: #{phone},验证码是: #{captcha_code},请在一天内注册.
      如果不是您本人的操作,请忽略此条短信.
    EOF
  end

  def generate_temp_email(phone)
    phone.to_s + "@temp.com"
  end

  def is_mobile_exist?(mobile)
    User.find_by_mobile(mobile).nil? ? false : true
  end
end
