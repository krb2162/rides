class RidesController < ApplicationController
  #@driver

  def index
    Ride.available.in_future.sort_by(&:score).reverse
  end

  # def best_rides
  # end
end
