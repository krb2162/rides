class RidesController < ApplicationController
  #FIXME: update when make final route
  def index
    rides = Ride.available.in_future.to_a.sort { |a,b| b.score(driver_id: driver_id) <=> a.score(driver_id: driver_id) }
    render json: RideBlueprint.render(rides, view: :extended)
  end

  private
 
  def driver_id
    params[driver_id]
  end
end
