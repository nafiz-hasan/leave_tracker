class ChangeYearlyValuesOfStat < ActiveRecord::Migration
  def change
    change_column :stats, :yearly_casual_leave, :integer, default: 10
    change_column :stats, :yearly_sick_leave, :integer, default: 6
  end
end
