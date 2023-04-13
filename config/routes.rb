Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #TODO: come up with a good name for a custom endpt
  #nested?
  get "/rides/:driver_id", to: "rides#index"

  
end