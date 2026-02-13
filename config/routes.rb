Rails.application.routes.draw do
  root to: "posts#index"
  
  get 'find_friends', to: 'users#index'
  get 'my_friends', to: 'users#my_friends'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
  
  resources :posts
  resources :friendships, only: [:create, :destroy]
end