class NewsController < ApplicationController
  
  def index
    @news = NewsPost.all
  end
  
end
