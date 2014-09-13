class AddUserRefToNewsPost < ActiveRecord::Migration
  def change
    add_reference :news_posts, :user, index: true
  end
end
