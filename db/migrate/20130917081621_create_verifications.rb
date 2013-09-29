class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.integer  :user_id
      t.string   :mobile
      t.string   :mobile_captcha_code
      t.string   :temp_email
      t.boolean  :is_auth_for_mobile, :default => false
      t.datetime :mobile_last_sent_at

      t.datetime :created_at
    end
  end
end
