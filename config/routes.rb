Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # resources :drivers, only: [:index]
  get "/drivers", to: "drivers#index"
  resources :rides

  # Defines the root path route ("/")
  # root "articles#index"
end
