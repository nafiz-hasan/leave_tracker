class ChangeDataTypeForHours < ActiveRecord::Migration
  def change
    change_column :days, :hours, :decimal, default: 8.0, precision: 2, scale: 1
  end
end
