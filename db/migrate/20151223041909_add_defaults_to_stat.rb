class AddDefaultsToStat < ActiveRecord::Migration
  def change
    change_column :stats, :carried_leave, :decimal, default: 0
    change_column :stats, :consumed_casual_leave, :decimal, default: 0
    change_column :stats, :consumed_sick_leave, :decimal, default: 0
    change_column :stats, :start_date, :date, default: Date.today
  end
end
