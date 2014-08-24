class AddLastchangeToUser < ActiveRecord::Migration
  def change
    add_column :users, :lastchange, :integer
  end
end
