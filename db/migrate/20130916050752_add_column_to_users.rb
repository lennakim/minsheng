class AddColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :mobile, :string
    add_column :users, :is_auth_for_mobile, :boolean, :default => false
  end

  def down
    remove_column :users, :mobile
    remove_column :users, :is_auth_for_mobile
  end
end
