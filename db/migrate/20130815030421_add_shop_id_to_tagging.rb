class AddShopIdToTagging < ActiveRecord::Migration
  def change
    add_column :taggings, :shop_id, :integer
  end
end
