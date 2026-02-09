Rails.application.routes.draw do
  get "posts/index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: "posts#index" 
  
  resources :posts
end
