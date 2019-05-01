Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  resources :order_products
  resource :cart, only: [:show]

<<<<<<< HEAD
  resources :products, only: [:index, :show, :new, :create, :edit]
  resources :sellers, only: [:show]
=======
  resources :products, only: [:index, :show, :new, :create]

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sellers#create", as: "auth_callback"
  delete "/logout", to: "sellers#destroy", as: "logout"
>>>>>>> 04cebd6ce873052b07f554a1e48acc17c8e03440
end
