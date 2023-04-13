class RidesController < ApplicationController
  #@driver
  before_action :fetch_driver

  def index
    # Ride.available.in_future.sort_by(&:score).reverseA
    #TODO: add serializer/formatting render
    render json: Ride.available.in_future.to_a.sort { |a,b| b.score(@driver.id) <=> a.score(@driver.id) }
    # render json: Ride.in_future.to_a.sort { |a,b| b.score(@driver.id) <=> a.score(@driver.id) }
  end

  #TODO with driver_id in path?
  # def best_rides
    # Ride.available.in_future.to_a.sort { |a,b| b.score(@driver.id) <=> a.score(@driver.id) }
  # end
  private

  #TODO: memoize
  def fetch_driver
    @driver = Driver.find(params[:driver_id])
  end
end
