class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_password_token_for_mobile ,:string
    add_column :users,:reset_password_sent_at_for_mobile, :datetime
  end

  def down
    remove_column :users, :reset_password_token_for_mobile
    remove_column :users, :reset_password_sent_at_for_mobile
  end
end
