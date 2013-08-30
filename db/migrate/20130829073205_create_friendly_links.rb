class CreateFriendlyLinks < ActiveRecord::Migration
  def change
    create_table :friendly_links do |t|
      t.string :name
      t.string :url
      t.integer :sort, default: 0

      t.timestamps
    end

    add_index :friendly_links, :sort
  end
end
