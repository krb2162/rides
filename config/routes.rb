Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/rides", to: "drivers#index"
  #custom rides endpoint?
end