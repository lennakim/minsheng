class CreateShopImages < ActiveRecord::Migration
  def change
    create_table :shop_images do |t|
      t.string :image
      t.integer :shop_id

      t.timestamps
    end
  end
end
