class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_column :users, :admin, :boolean
    add_column :users, :ttf_id, :integer
    add_column :users, :sttf_id, :integer
  end
end
