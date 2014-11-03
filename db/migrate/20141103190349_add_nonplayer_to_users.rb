class AddNonplayerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nonplayer, :boolean
  end
end
