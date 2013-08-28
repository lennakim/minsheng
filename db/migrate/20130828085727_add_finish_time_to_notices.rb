class AddFinishTimeToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :finish_time, :datetime
  end
end
