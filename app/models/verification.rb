class Verification < ActiveRecord::Base
  attr_accessible :user_id, :mobile, :mobile_captcha_code, :is_auth_for_mobile, :mobile_last_sent_at, :temp_email

  INTERVAL_TIME = 60
  EXPIRE_TIME = 60*60*24

  # get user verification
  def self.last_verification(mobile, user_id = nil)
    Verification.where("user_id = ? OR mobile = ? ", user_id, mobile).order("created_at DESC").first
  end

  # gt greater than
  def self.is_gt_interval_time?(user_id, mobile)
    verification = Verification.last_verification(user_id, mobile)

    if verification
      Time.now.to_i - verification.mobile_last_sent_at.to_i > INTERVAL_TIME ? true : false
    else
      true
    end
  end

  # lt less than
  def self.is_lt_expire_time?(time)
    Time.now.to_i - time.to_i < EXPIRE_TIME ? true : false
  end

  # generate_captcha_code
  def self.generate_captcha_code
    [*'a'..'z',*'1'..'9'].sample(4).join
  end
end
