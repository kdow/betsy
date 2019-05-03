Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"

  resources :order_products
  resource :cart, only: [:show]

  resources :products, only: [:index, :show]
  resources :sellers, only: [:show]

<<<<<<< HEAD
  resources :sellers do
    resources :products, only: [:create, :new, :edit, :update]
=======
  resources :categories do
    resources :products, only: [:index, :new]
>>>>>>> master
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sellers#create", as: "auth_callback"
  delete "/logout", to: "sellers#destroy", as: "logout"
end
