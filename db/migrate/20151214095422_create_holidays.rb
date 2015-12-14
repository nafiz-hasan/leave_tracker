class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.references :user, index: true, foreign_key: true
      t.string :reason
      t.text :description
      t.string :type, default: "casual"
      t.string :status, default: "pending"

      t.timestamps null: false
    end
  end
end
