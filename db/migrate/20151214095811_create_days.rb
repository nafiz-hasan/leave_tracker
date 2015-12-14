class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.references :holiday, index: true, foreign_key: true
      t.date :the_date
      t.integer :hours, default: 8

      t.timestamps null: false
    end
  end
end
