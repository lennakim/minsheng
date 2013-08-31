class CreatePageAds < ActiveRecord::Migration
  def up
    create_table :page_ads do |t|
      t.integer :flag_type, :null => false
      t.string :name, :null => false, :default => ''
      t.string :href, :null => false, :default => ''
      t.string :image_url, :null => false, :default => ''
      t.string :ad_desc, :null => false, :default => ''
      t.datetime :start_time
      t.datetime :end_time
      t.integer :sort, :null => false, :default => 0

      t.timestamps
    end
  end

  def down
    drop_table :page_ads
  end
end
