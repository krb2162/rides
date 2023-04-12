class RidesController < ApplicationController
  #@driver

  def index
    Ride.available.in_future.sort_by(&:score).reverse
  end

  # def best_rides
  # end
  private

  def driver
    Driver.find(params[:driver_id])
  end
#TODO: look into memoization
  # def fetch_ride
  #   @ride = Ride.find(params[:id])
  # end

  

  def commute_time
    GetDirectionsService.run!(start_loc: driver.home_address, end_loc: @ride.pick_up_at)
  end

  def score
    @ride.route.earnings / (commute_time + @ride.route.time_minutes)
  end
end
