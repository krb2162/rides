class RidesController < ApplicationController
  def index # use param for index filtering, no filter param defaults to all rides
    render json: RideBlueprint.render(paginated_rides(rides), view: :extended)
  end

  private
 
  def driver_id
    params[:driver_id]
  end

  def rides # extendable for other type params -> 'past', 'future', 'next', etc...
    if params[:filter] == 'score'
      Ride.available.in_future.sort { |a,b| b.score <=> a.score }
    else
      Ride.all
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
