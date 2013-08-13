class AddComfirmableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :string, :null => false, :default => ''
    add_column :users, :confirmed_at, :datetime, :null => false, :default => '1970-01-01'
    add_column :users, :confirmation_sent_at, :datetime, :null => false, :default => '1970-01-01'
    add_column :users, :unconfirmed_email, :string, :null => false, :default => ''
    # t.string   :confirmation_token
    # t.datetime :confirmed_at
    # t.datetime :confirmation_sent_at
    # t.string   :unconfirmed_email # Only if using reconfirmable
  end
end
