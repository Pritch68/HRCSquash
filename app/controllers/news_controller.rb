class NewsController < ApplicationController
  
  def index
    @news = NewsPost.all.order(created_at: :desc)
  end

  def new
    @news = NewsPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @score }
    end
  end
  
  def create
    @news = NewsPost.new(news_params)
    @news.active = true
    @news.user = current_user
    @news.save
    redirect_to news_posts_path, notice: 'News item created'
  end
  
  def destroy
    @news = NewsPost.find(params[:id])
    @news.destroy
    redirect_to news_posts_path, alert: 'News item deleted.'
  end
  
  def edit
    @news = NewsPost.find(params[:id])
  end
  
  def update
    @news = NewsPost.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(news_params)
        format.html { redirect_to news_posts_path, notice: 'News item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def news_params
    params.require(:news_post).permit(:title, :body)
  end
  
end
