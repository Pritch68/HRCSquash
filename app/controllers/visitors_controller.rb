class VisitorsController < ApplicationController
  
  def index
    # @users = User.active.ranked.limit(10)
    @frontscores = Score.recent.limit(15)
    @news = NewsPost.recent.limit(3)
    @events = Event.upcoming.limit(15)
    
    flash.now[:notice] = 'Single Day Tournament This Saturday - Contact Leah or Front Desk to Register!'
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
