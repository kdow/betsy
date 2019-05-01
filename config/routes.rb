Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :show, :new, :create]

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "sellers#create"
  delete "/logout", to: "sellers#destroy", as: "logout"
end
