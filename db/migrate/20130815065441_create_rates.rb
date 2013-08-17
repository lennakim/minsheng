class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :rank
      t.text :comment

      t.integer :user_id, :null => false
      t.integer :shop_id, :null => false
      t.timestamps
    end
  end
end
