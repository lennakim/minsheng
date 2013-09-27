class AddNameToShopImage < ActiveRecord::Migration
  def change
    add_column :shop_images, :name, :string
    add_column :shop_images, :flag_type, :string
  end
end
