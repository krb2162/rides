class Ride < ApplicationRecord
    belongs_to :driver, optional: true
    belongs_to :route

    validates_presence_of :pick_up_at

    paginates_per 10

    scope :in_future, -> { where(pick_up_at: Time.zone.now...) }
    scope :available, -> { where(driver_id: nil) }

    # these are public for future use 
    def score
        return nil if driver.nil? #may want to blow up loudly instead

        route.earnings / (commute_time/60.0 + route.time_minutes/60.0)
    end

    def commute_time
        return nil if driver.nil? #may want to blow up loudly instead

        GetRouteService.run!(start_address: driver.home_address,
            end_address: route.start_address).time_minutes
    end
end
