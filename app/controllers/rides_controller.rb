class RidesController < ApplicationController
  def index #FIXME: choose a good custom route name and update
    @rides = Ride.available.in_future.sort { |a,b| b.score(driver_id: driver_id) <=> a.score(driver_id: driver_id) }

    render json: RideBlueprint.render(paginated_rides, view: :extended)
  end

  private
 
  def driver_id
    params[:driver_id]
  end

  def paginated_rides
    return @rides if params[:page].nil? && params[:page_limit].nil?

    page = params[:page].nil? ? 1 : params[:page]
    #TODO: if receiving page_limit param without page param is unexpected,
      #then log to Sentry or other error log

    if params[:page_limit]
      Ride.where(id: @rides.map(&:id)).page(page).per(params[:page_limit])
    else
      Ride.where(id: @rides.map(&:id)).page(page)
    end
  end
end
