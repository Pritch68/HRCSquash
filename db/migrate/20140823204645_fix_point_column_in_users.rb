class FixPointColumnInUsers < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.rename :point, :points
    end
  end
end
