class Ride < ApplicationRecord
    belongs_to :driver, optional: true
    belongs_to :route

    paginates_per 10

    scope :in_future, -> { where(pick_up_at: Time.zone.now...) }
    scope :available, -> { where(driver_id: nil) }
    #TODO? want to add custom scope for sorting by score? 

    def score(driver_id:)
        self.route.earnings / (commute_time(driver_id: driver_id)/60.0 + self.route.time_minutes/60.0)
    end

    def commute_time(driver_id:)
        GetRouteService.run!(start_address: Driver.find(driver_id).home_address,
            end_address: self.route.start_address).time_minutes
    end
end
