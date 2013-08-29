class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :flag_type
      t.string :title
      t.text :content
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
