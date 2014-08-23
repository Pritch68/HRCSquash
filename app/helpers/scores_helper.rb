module ScoresHelper
	
	def homescore s
		case s
			when 0 then "3-0"
			when 1 then "3-1"
			when 2 then "3-2"
			when 3 then "2-3"
			when 4 then "1-3"
			when 5 then "0-3"
			else
				"Invalid score: "+s.to_s
		end		
	end
	
	def visitorscore s
		case s
			when 5 then "3-0"
			when 4 then "3-1"
			when 3 then "3-2"
			when 2 then "2-3"
			when 1 then "1-3"
			when 0 then "0-3"
			else
				"Invalid score: "+s.to_s
		end		
	end
		
end