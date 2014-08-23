class Score < ActiveRecord::Base

  belongs_to :homeplayer, :class_name => "User", :foreign_key => "player1_id"
	belongs_to :visitingplayer, :class_name => "User", :foreign_key => "player2_id"
  
  validates_associated :homeplayer, :visitingplayer
	validates_presence_of :date, :player1_id, :player2_id, :matchscore
	validate :no_duplicate_players, :match_cannot_be_in_the_future, :no_duplicate_scores
	
	scope :withplayer, lambda {|uid| where("player1_id = ? OR player2_id = ?", uid, uid)}
	scope :recent, order("scores.date DESC, scores.created_at DESC")
	
	def no_duplicate_players
		if player1_id == player2_id
			errors.add(:player2_id, "Cannot play yourself!")
		end
	end
	
	def match_cannot_be_in_the_future
		if date > Date.today
			errors.add(:date, "Match cannot be in the future")
		end
	end

	def no_duplicate_scores
		_query1 = "select id from scores where player1_id = "+player1_id.to_s+" and player2_id = "+player2_id.to_s+" and date::date = '"+date.to_s+"'"
		_query2 = "select id from scores where player1_id = "+player2_id.to_s+" and player2_id = "+player1_id.to_s+" and date::date = '"+date.to_s+"'"
		result1 = Score.find_by_sql(_query1)
		result2 = Score.find_by_sql(_query2)
		if result1.count + result2.count > 0
			errors.add(:date, "A score against this opponent has already been recorded for this date. Only 1 match against this opponent can be recorded per day.")
		end
	end
		
	def player1_score
		case self.matchscore
		when 5
			0
		when 4
			1
		when 3
			2
		else
			3
		end
	end
		
	def player2_score
		case self.matchscore
		when 0
			0
		when 1
			1
		when 2
			2
		else
			3
		end
	end
	
	# Calculate points change for both players based on their respective total points
	# and match result, using Elo formula
	# D = 1000, K = {50,38,25} based on 3-0,3-1,3-2 result
	def self.calculate_elo p1, p2, s
		
		_we1 = 1.0 / (10**((p2-p1)/1000.0)+1)
    _we2 = 1.0 / (10**((p1-p2)/1000.0)+1)

		case s
		when 0 # p1 won 3-0
			_p1change = 50*(1.0-_we1)
			_p2change = -_p1change
		when 1 # p1 won 3-1
			_p1change = 38*(1.0-_we1)
			_p2change = -_p1change
		when 2 # p1 won 3-2
			_p1change = 25*(1.0-_we1)
			_p2change = -_p1change
		when 3 # p2 won 3-2
			_p2change = 25*(1.0-_we2)
			_p1change = -_p2change
		when 4 # p2 won 3-1
			_p2change = 38*(1.0-_we2)
			_p1change = -_p2change
		when 5 # p2 won 3-0
			_p2change = 50*(1.0-_we2)
			_p1change = -_p2change
		else
			_p1change = 0.0
			_p2change = 0.0
		end
												
		return _p1change.round, _p2change.round
	end	
	
	# Return an array of dates and point totals for player
	# Maximum number of point changes = 30
	def self.player_history pid
		_query = "select date, player1_change, created_at from scores where player1_id = "+pid.to_s+" union all select date, player2_change, created_at from scores where player2_id = "+pid.to_s+" order by date DESC, created_at DESC limit 30"
		results = self.find_by_sql(_query)
		p = User.find(pid).points
		i = results.count - 1
		r = Array.new(i+1) {Array.new(2)}
		for x in results do
			r[i][0] = x.date
			r[i][1] = p
			p = p - x.player1_change
			i = i -1
		end
		return r
	end
	
	def self.player_head2head p1,p2
		s = self.withplayer(p1).where('player1_id = ? or player2_id = ?',p2,p2).order('scores.date DESC')
		_total_matches = s.count
		_p0 = s.where('(player1_id = ? and matchscore = 0) or (player2_id = ? and matchscore = 5)',p1,p1).count
		_p1 = s.where('(player1_id = ? and matchscore = 1) or (player2_id = ? and matchscore = 4)',p1,p1).count
		_p2 = s.where('(player1_id = ? and matchscore = 2) or (player2_id = ? and matchscore = 3)',p1,p1).count
		_p3 = s.where('(player1_id = ? and matchscore = 3) or (player2_id = ? and matchscore = 2)',p1,p1).count
		_p4 = s.where('(player1_id = ? and matchscore = 4) or (player2_id = ? and matchscore = 1)',p1,p1).count
		_p5 = s.where('(player1_id = ? and matchscore = 5) or (player2_id = ? and matchscore = 0)',p1,p1).count
		stats = [_total_matches,_p0,_p1,_p2,_p3,_p4,_p5]
		return s, stats
	end
end
