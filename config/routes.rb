Rails.application.routes.draw do
  root to: 'products#index'
  devise_for :users

  resources :products, only: %i[index show]
  resources :carts, only: %i[show]
end
