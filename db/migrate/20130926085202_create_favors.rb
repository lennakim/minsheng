class CreateFavors < ActiveRecord::Migration
  def change
    create_table :favors do |t|
      t.integer :shop_id
      t.integer :user_id

      t.timestamps
    end
  end
end
