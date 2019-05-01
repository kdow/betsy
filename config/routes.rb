Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  resources :order_products
  resource :cart, only: [:show]

<<<<<<< HEAD
<<<<<<< HEAD
  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :sellers, only: [:show]
=======
  resources :products, only: [:index, :show, :new, :create]
=======

  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :sellers, only: [:show]
>>>>>>> 97f0d79db782da17ce0cb2a995f786535b16af77

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sellers#create", as: "auth_callback"
  delete "/logout", to: "sellers#destroy", as: "logout"
<<<<<<< HEAD
>>>>>>> 04cebd6ce873052b07f554a1e48acc17c8e03440
=======

>>>>>>> 97f0d79db782da17ce0cb2a995f786535b16af77
end
