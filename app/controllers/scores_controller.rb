class ScoresController < ApplicationController

# GET /scores
  # GET /scores.json
  
  def enter
  end
  
  def index
    @scores = Score.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scores }
    end
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
    @score = Score.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @score }
    end
  end

  # GET /scores/new
  # GET /scores/new.json
  def new
    @score = Score.new
    @score.date = Time.now-4.hours

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @score }
    end
  end

  # GET /scores/1/edit
  def edit
    @score = Score.find(params[:id])
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(params[:score])
    @score.player1_id = current_user.id # Ensure player entering the score is recorded as home player

		if @score.player2_id? then
	  	# Get current point total for each player
			_u1 = User.find(@score.player1_id)
			_u2 = User.find(@score.player2_id)
			
			# Calculate the impact of this match on each players point total
	  	@score.player1_change, @score.player2_change = Score.calculate_elo(_u1.points, _u2.points, @score.matchscore)
	    
	  	# Update each players point total
	  	_u1.points += @score.player1_change
	  	_u2.points += @score.player2_change
	  	
	  	# Update each players last point change
	  	_u1.lastchange = @score.player1_change
	  	_u2.lastchange = @score.player2_change
	  	
	    respond_to do |format|
	      if @score.save
    	  	# Save changes to each player only if the score is successfully saved
			  	_u1.save
	  			_u2.save
	  			
	  			
			  	#  Tweet result
			  	# if @score.matchscore < 3
			  	# 	_tweet = @score.homeplayer.name+" bt "+@score.visitingplayer.name+", "+view_context.homescore(@score.matchscore)
			  	# else
			  	# 	_tweet = @score.visitingplayer.name+" bt "+@score.homeplayer.name+", "+view_context.visitorscore(@score.matchscore)
			  	# end
			  	# Twitter.update(_tweet)

	        format.html { redirect_to '/home', notice: 'Score was successfully recorded.'}
	        format.json { render json: @score, status: :created, location: @score }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @score.errors, status: :unprocessable_entity }
	      end
	    end
	  
	  else
	  	
	  	render action: "new"
	  	
	  end
  end

  # PUT /scores/1
  # PUT /scores/1.json
  def update
    @score = Score.find(params[:id])

    respond_to do |format|
      if @score.update_attributes(params[:score])
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    respond_to do |format|
      format.html { redirect_to scores_url }
      format.json { head :no_content }
    end
  end
end