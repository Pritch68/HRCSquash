class VisitorsController < ApplicationController
  
  def index
    @users = User.active.ranked.limit(10)
    @frontscores = Score.recent.limit(10)
  end
  
  def rankings
		@users = User.active.ranked.all
	end
  
  def recentscores
		@frontscores = Score.recent.limit(50)
	end
  
  def help
  end
  
end
