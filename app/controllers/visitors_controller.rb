class VisitorsController < ApplicationController
  
  def index
    @users = User.active.ranked.limit(10)
    @frontscores = Score.recent.limit(10)
  end
  
end
