Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/rides/:driver_id", to: "rides#index"
end