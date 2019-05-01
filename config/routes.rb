Rails.application.routes.draw do
  resources :order_products
  resource :cart, only: [:show]

  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :sellers, only: [:show]
end
