Rails.application.routes.draw do
  root to: "posts#index"
  
  get 'find_friends', to: 'users#index'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
  
  resources :posts
  resources :friendships, only: [:create, :destroy]
end