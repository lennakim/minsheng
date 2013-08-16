class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :tag_type
      t.string :title
      t.text :content
      t.datetime :issue_time

      t.timestamps
    end
  end
end
