class RemoveDateFromStat < ActiveRecord::Migration
  def change
    remove_column :stats, :start_date, :date
  end
end
