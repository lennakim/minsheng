# encoding: utf-8

class UcenterController < ApplicationController
  layout 'ucenter'
  def index

  end

  def suggestion
    @suggestion = Suggestion.new
  end

  def inbox
  end

  def comment
  end

  def settings
  end

  def change_password
  end

  def favorite
  end

  def view_history
  end

  def update_password
    user = current_user.reload
    user.current_password = params[:user][:current_password]
    user.in_password_reset = true
    user_params = params[:user].slice(:current_password, :password, :password_confirmation)
    if user.update_with_password(user_params)
      sign_in :user, user, :bypass => true
      result = {msg: '修改成功'}
    else
      result = {msg: (user.errors.first || []).last}
    end
    render json: result
  end

  def region_list
    records = []
    case params[:type]
    when 'city'
      records = Province.find(params[:province_id]).cities.map{|item| {name: item.name, id: item.id}}
    when 'community'
      City.find(params[:city_id]).districts.each do |district|
        records += district.communities.map{|item| {name: item.name, id: item.id}}
      end
    end
    render json: records
  end

  def send_sms
    mobile = params[:mobile]
    if mobile_exist?(mobile)
      msg = '此手机已经注册'
    else
      verify_code = User.generate_password_token
      content = generate_sms_content(mobile, verify_code)

      # todo
      logger.debug{content}
      #result = Sms.send_message_by_smsbao(mobile, content)
      # if result[:success]
      if true
        user.update_attributes({mobile: mobile, reset_password_token_for_mobile: verify_code,
          reset_password_sent_at_for_mobile: Time.now})
        msg = '发送成功'
      else
        msg = '发送失败'
      end
    end
    render json: {msg: msg}
  end


  def verify_mobile_code
    verify_code = params[:verify_code]
    if !Verification.is_lt_expire_time?(current_user.reset_password_sent_at_for_mobile)
      msg = '时间已经过期'
    else
      if current_user.reset_password_token_for_mobile.downcase == verify_code.downcase
        current_user.update_attributes({is_auth_for_mobile: true})
        msg = '绑定手机成功'
      else
        msg = '验证码错误'
      end
    end
    render json: {msg: msg}
  end

  private
  def generate_sms_content(mobile, verify_code)
    content = <<-EOF
      您的手机号码是: #{mobile},验证码是: #{verify_code},请在一天内注册.
      如果不是您本人的操作,请忽略此条短信.
    EOF
  end

  def mobile_exist?(mobile)
    User.find_by_mobile(mobile).nil? ? false : true
  end
end
