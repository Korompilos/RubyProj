Rails.application.routes.draw do
  root to: "posts#index"

  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }

  get 'find_friends', to: 'users#index'
  get 'my_friends', to: 'users#my_friends'
  resources :users, only: [:show]

  resources :posts
  resources :friendships, only: [:create, :destroy]

  resources :rooms do
    resources :messages, only: [:create, :destroy]
  end
end