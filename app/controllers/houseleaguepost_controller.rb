class HouseleaguepostController < ApplicationController
 
  def index
    @news = Houseleaguepost.all.order(created_at: :desc)
  end

  def show
    @news = Houseleaguepost.find(params[:id])
  end
  
  def new
    @news = Houseleaguepost.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @news = Houseleaguepost.new(news_params)
    if @news.save
      redirect_to houseleagueposts_path, notice: 'House League item created'
    else
      render 'new'
    end
  end
  
  def destroy
    @news = Houseleaguepost.find(params[:id])
    @news.destroy
    redirect_to houseleaguepost_path, alert: 'House League item deleted.'
  end
  
  def edit
    @news = Houseleaguepost.find(params[:id])
  end
  
  def update
    @news = Houseleaguepost.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(news_params)
        format.html { redirect_to houseleaguepost_path, notice: 'House League item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def news_params
    params.require(:houseleaguepost).permit(:title, :body)
  end
 
end
