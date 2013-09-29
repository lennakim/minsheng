class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string :web_image
      t.string :mobile_image
      t.text :description
      t.datetime :end_date
      t.string :content
      t.integer :shop_id

      t.timestamps
    end
  end
end
