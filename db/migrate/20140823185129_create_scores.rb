class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.datetime :date
      t.integer :player1_id
      t.integer :player2_id
      t.integer :matchscore
      t.integer :player1_change
      t.integer :player2_change

      t.timestamps
    end
  end
end
