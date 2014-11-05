Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :scores
  resources :news_posts, controller: "news", path: "news"
  resources :tanddposts, controller: "tanddpost", path: "tandd"
  resources :houseleagueposts, controller: "houseleaguepost", path: "houseleague"
  resources :events
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  get "/rankings" => "visitors#rankings"
  get "/recentscores" => "visitors#recentscores"
  get "/help" => "visitors#help"

end
