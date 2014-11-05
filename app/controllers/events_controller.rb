class EventsController < ApplicationController

  def index
    @events = Event.all.order(startdate: :desc)
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end
  
  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path, notice: 'Event created'
    else
      render 'new'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, alert: 'Event deleted.'
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to events_path, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def event_params
    params.require(:event).permit(:title, :body, :startdate, :enddate)
  end

end
