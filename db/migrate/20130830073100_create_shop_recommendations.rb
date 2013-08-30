class CreateShopRecommendations < ActiveRecord::Migration
  def change
    create_table :shop_recommendations do |t|
      t.integer :shop_id
      t.string :flag_type
      t.datetime :start_time
      t.datetime :end_time
      t.integer :sort, default: 0

      t.timestamps
    end
  end
end
