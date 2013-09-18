# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.image_data = params.slice(:top, :left, :width, :height)
    @user.update_attributes(params[:user])
    redirect_to user_path(@user)
  end

  def upload_image
    @user = User.find(params[:id])
  end

  def verification_mobile
    @user = User.find(params[:id])
  end

  def sent_mobile_captcha_code

    result = {}
    status, message = false, ""
    mobile = params[:mobile].to_i

    user = User.find(params[:id])

    if Verification.is_gt_interval_time?(user.id, mobile)

      captcha_code = Verification.generate_captcha_code

      content = generate_sms_content(mobile,captcha_code)

      result = Sms.send_message_by_smsbao(mobile,content) #发送短信

      if result[:success]
        create_verification(:user_id => user.id, :mobile_captcha_code => captcha_code, :mobile_last_sent_at => Time.now, :mobile => mobile)

        status, message = true, "短信发送成功"
      else
        status, message = false, "短信未发送成功"
      end
    else
      status, message = false, "请不要频繁发送"
    end

    render :json => { :status => status, :message => message }
  end

  def verify

    result, message = false, ""

    captcha_code = params[:captcha_code]
    user = User.find(params[:id])
    verification = Verification.last_verification(user.id)

    unless Verification.is_lt_expire_time?(verification.mobile_last_sent_at)
      result, message = false, "时间已经过期"
    else
      if verification.mobile_captcha_code.downcase == captcha_code.downcase
        verification.update_attribute(:is_auth_for_mobile, true)

        user.update_attributes(:is_auth_for_mobile => true, :mobile => verification.mobile)

        result, message = true, "绑定手机成功"
      else
        result, message = false, "验证码错误"
      end
    end

    render :json => { :status => result, :message => message }
  end

private

  def generate_sms_content(phone,captcha_code)
    content = <<-EOF
      您的手机号码是: #{phone},
      验证码是: #{captcha_code},请在一天内注册.
      如果不是您本人的操作,请忽略此条短信.
    EOF
  end

  def create_verification(attributes)
    v = Verification.new
    v.update_attributes(attributes)
  end
end
