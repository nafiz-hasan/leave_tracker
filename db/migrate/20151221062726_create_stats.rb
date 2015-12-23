class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :yearly_casual_leave, default: 10
      t.decimal :yearly_sick_leave, default: 6
      t.decimal :carried_leave
      t.decimal :gained_casual_leave
      t.decimal :gained_sick_leave
      t.decimal :consumed_casual_leave
      t.decimal :consumed_sick_leave

      t.timestamps null: false
    end
  end
end
