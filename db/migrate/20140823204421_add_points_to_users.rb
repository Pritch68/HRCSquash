class AddPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer
    add_index :users, :point
  end
end
