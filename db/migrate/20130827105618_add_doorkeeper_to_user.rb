class AddDoorkeeperToUser < ActiveRecord::Migration
  def change
    add_column :users, :doorkeeper_uid, :integer
    add_column :users, :doorkeeper_access_token, :string
  end
end
