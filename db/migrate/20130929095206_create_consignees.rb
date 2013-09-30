class CreateConsignees < ActiveRecord::Migration
  def change
    create_table :consignees do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :postcode
      t.string :mobile
      t.boolean :is_default, default: false

      t.timestamps
    end

    add_index :consignees, :user_id
    add_index :consignees, :is_default
  end
end
