Rails.application.routes.draw do

  get 'friendships/destroy'
  devise_for :users, :controllers => { :registrations => "user/registrations" }


  root 'pages#index'

  get 'pages/about'

  get 'portfolio', to: 'users#portfolio'

  get 'search_coins', to: 'coins#search'

  resources :user_coins, only: [:create, :destroy]

  get 'friends', to: 'users#friends'

  resources :users, only: [:show]

  resources :friendships

  get 'search_friends', to: 'users#search'

  post 'add_friend', to: 'users#add_friend'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
