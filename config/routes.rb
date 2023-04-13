Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #TODO: come up with a good name for a custom endpt
  get "/rides/:driver_id", to: "rides#index"
  #custom rides endpoint?
end