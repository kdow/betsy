Rails.application.routes.draw do
  resources :products
  resources :order_products
  resource :cart, only: [:show]

end
