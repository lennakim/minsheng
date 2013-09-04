class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :sender,   :null => false
      t.integer :receiver, :null => false
      t.string :title
      t.text :content
      t.boolean :is_read, :default => false

      t.timestamps
    end
  end
end
