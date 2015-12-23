class RemoveGainedFromStat < ActiveRecord::Migration
  def change
    remove_column :stats, :gained_casual_leave, :decimal
    remove_column :stats, :gained_sick_leave, :decimal
  end
end
