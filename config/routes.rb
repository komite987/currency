Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/about'
  get 'portfolio', to: 'users#portfolio'
  get 'search_coins', to: 'coins#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
