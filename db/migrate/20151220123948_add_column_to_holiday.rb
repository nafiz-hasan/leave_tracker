class AddColumnToHoliday < ActiveRecord::Migration
  def change
    add_column :holidays, :feedback, :text
  end
end
