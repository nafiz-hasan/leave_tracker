class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :holidays, :type, :holiday_type
  end
end
