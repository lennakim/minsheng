class AddLngLatToShop < ActiveRecord::Migration
  def change
    add_column :shops, :lng, :string
    add_column :shops, :lat, :string
  end
end
