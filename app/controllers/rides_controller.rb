class RidesController < ApplicationController
  def index # use params for index filtering, no filter param defaults to all rides
    render json: RideBlueprint.render(paginated_rides(rides), view: :extended)
  end

  private

  # don't need any safety checking on params
    # ex. no create/updates, ...

  def driver
    Driver.find(params[:driver_id]) #could memoize if we want
  end

  # extendable for classic GET rides (add route pointing to this controller method & handle logic in index) and other type params -> 'past', 'future', 'next', etc...
  def rides
   # ex. return Ride.all if params[:driver_id].nil? # would handle classic GET
    if params[:filter] == 'score'
      Ride.available.in_future.sort { |a,b| b.score <=> a.score }
    else
      driver.rides
    end
  end

  # made flexible pagination with built in 10 standard 
    # since not sure what the front end requirements/usecases are
  def paginated_rides(rides)
    return rides if params[:page].nil? && params[:page_limit].nil?

    page = params[:page].nil? ? 1 : params[:page]
    #TODO: if receiving page_limit param without page param is unexpected,
      #then log to Sentry or other error logger used with codebase
      #potentially unnecessary to break loudly here, so default to page 1

    if params[:page_limit]
      Ride.where(id: rides.map(&:id)).page(page).per(params[:page_limit])
    else
      Ride.where(id: rides.map(&:id)).page(page)
    end
  end
end
