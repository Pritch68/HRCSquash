class TanddpostController < ApplicationController
 
  def index
    @news = Tanddpost.all.order(created_at: :desc)
  end

  def show
    @news = Tanddpost.find(params[:id])
  end
  
  def new
    @news = Tanddpost.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @news = Tanddpost.new(news_params)
    if @news.save
      redirect_to tanddposts_path, notice: 'T&D item created'
    else
      render 'new'
    end
  end
  
  def destroy
    @news = Tanddpost.find(params[:id])
    @news.destroy
    redirect_to tanddpost_path, alert: 'T&D item deleted.'
  end
  
  def edit
    @news = Tanddpost.find(params[:id])
  end
  
  def update
    @news = Tanddpost.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(news_params)
        format.html { redirect_to tanddpost_path, notice: 'T&D item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def news_params
    params.require(:tanddpost).permit(:title, :body)
  end
  
end
