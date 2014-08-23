class Score < ActiveRecord::Base

  belongs_to :homeplayer, :class_name => "User", :foreign_key => "player1_id"
	belongs_to :visitingplayer, :class_name => "User", :foreign_key => "player2_id"
  
end
