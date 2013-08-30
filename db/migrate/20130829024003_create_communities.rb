class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.integer :district_id, :null => false
      t.string  :name,        :null => false
      t.string  :address
      t.text    :description

      t.timestamps
    end
  end
end
