class Ride < ApplicationRecord
    belongs_to :driver
    belongs_to :route

    scope :in_future, -> { where(pick_up_at: Time.zone.now...) }
    scope :available, -> { where(driver_id: nil) }
    # scope :by_score, -> { order(score: :desc) }

    def score(driver_id)
        self.route.earnings / (commute_time(driver_id) + self.route.time_minutes)
    end

    def commute_time(driver_id) #FIXME 
        GetDirectionsService.run!(start_address: Driver.find(driver_id).home_address, end_address: self.route.pick_up_address)
    end
end
