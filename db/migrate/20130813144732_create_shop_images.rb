class CreateShopImages < ActiveRecord::Migration
  def change
    create_table :shop_images do |t|
      t.string :url
      t.integer :shop_id

      t.timestamps
    end
  end
end
