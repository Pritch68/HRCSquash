class VisitorsController < ApplicationController
  
  def index
    @users = User.all
    @frontscores = Score.all
  end
  
end
