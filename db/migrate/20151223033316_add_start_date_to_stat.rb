class AddStartDateToStat < ActiveRecord::Migration
  def change
    add_column :stats, :start_date, :date
  end
end
