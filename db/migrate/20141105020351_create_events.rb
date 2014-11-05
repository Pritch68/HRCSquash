class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :startdate
      t.datetime :enddate
      t.text :body

      t.timestamps
    end
  end
end
