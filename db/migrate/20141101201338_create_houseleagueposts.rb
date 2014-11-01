class CreateHouseleagueposts < ActiveRecord::Migration
  def change
    create_table :houseleagueposts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
