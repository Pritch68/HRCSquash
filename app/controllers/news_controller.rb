class NewsController < ApplicationController
  
  def index
    @news = NewsPost.all
  end
  
  def destroy
    @news = NewsPost.find(params[:id])
    @news.destroy
    redirect_to news_posts_path, alert: 'News post deleted.'
  end
  
  def edit
    @news = NewsPost.find(params[:id])
  end
  
  def update
    @news = NewsPost.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(news_params)
        format.html { redirect_to news_posts_path, notice: 'News post was successfully updated.' }
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
