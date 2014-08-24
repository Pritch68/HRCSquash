class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
	  @user = User.find(params[:id])
	  @scores = Score.withplayer(params[:id]).recent.limit(10)
	  @history = Score.player_history(params[:id])
	  @stats = User.stats(params[:id])
	  @opponents = User.where('id != ?', @user.id).order('name')
	end

#	def head2head
#		@user = User.find(params[:p1])
#		@player2 = User.find(params[:p2])
#		@scores, @stats = Score.player_head2head(@user.id,@player2.id)
#	end	

end
