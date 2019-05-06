Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"

  resources :order_products
  resource :cart, only: [:show]
  resources :order, only: [:new, :update, :show]

  resources :products, only: [:index, :show]
  get "products/seller/:seller_id", to: "sellers#seller_products", as: "seller_products"


  resources :sellers, only: [:show]

  resources :sellers do
    resources :products, only: [:create, :new, :edit, :update]
    get "/products/", to: "sellers#product_index"
    get "/products/:id/categories", to: "sellers#product_categories_edit", as: "product_categories"
    patch "/products/:id/categories", to: "sellers#product_categories_update"
    get "/order_products/", to: "sellers#order_product_index"
    get "/order/:order_id", to: "sellers#order_show", as: "order"
  end

  resources :categories do
    resources :products, only: [:index, :new]
  end

  resources :products do
    resources :reviews, only: [:new, :create]
  end
  
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sellers#create", as: "auth_callback"
  delete "/logout", to: "sellers#destroy", as: "logout"
end
