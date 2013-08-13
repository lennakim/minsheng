class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :title,:null => false
      t.string :phone,:null => false
      t.string :address,:null => false

      t.timestamps
    end
  end
end
