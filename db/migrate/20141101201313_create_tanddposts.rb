class CreateTanddposts < ActiveRecord::Migration
  def change
    create_table :tanddposts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
