class AddActivetoNewsPost < ActiveRecord::Migration
  def change
    add_column :news_posts, :active, :boolean
  end
end
