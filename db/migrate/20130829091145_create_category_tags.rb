class CreateCategoryTags < ActiveRecord::Migration
  def change
    create_table :category_tags do |t|
      t.integer :category_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :category_tags, :category_id
    add_index :category_tags, :tag_id
  end
end
