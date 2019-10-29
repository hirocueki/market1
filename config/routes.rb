Rails.application.routes.draw do
  root to: 'products#index'

  devise_for :users

  resources :products, only: %i[index show] do
    resources :cart_items , only: %i[create destroy]
  end

  resource :carts, only: %i[show]
  resources :orders, only: %i[create]
end
