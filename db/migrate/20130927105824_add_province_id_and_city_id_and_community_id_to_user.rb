class AddProvinceIdAndCityIdAndCommunityIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :province_id, :integer
    add_column :users, :city_id, :integer
    add_column :users, :community_id, :integer
    add_column :users, :sex, :string

    add_index :users, :province_id
    add_index :users, :city_id
    add_index :users, :community_id
  end
end
