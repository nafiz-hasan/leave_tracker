class AddCommenceDateToStat < ActiveRecord::Migration
  def change
    add_column :stats, :commence_date, :date
  end
end
