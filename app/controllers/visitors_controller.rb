class VisitorsController < ApplicationController
  
  def index
    # @users = User.active.ranked.limit(10)
    @frontscores = Score.recent.limit(15)
    @news = NewsPost.recent.limit(7)
    @events = Event.upcoming.limit(15)
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
