class Ride < ApplicationRecord
    belongs_to :driver
    belongs_to :route

    scope :in_future, -> { where(pick_up_at: Time.zone.now...) }
    scope :available, -> { where(driver_id: nil) }
    # scope :by_score, -> { order(score: :desc) }

    # def score
    #     self.route.earnings / (commute_time + self.route.time_minutes)
    # end

    # def commute_time #FIXME 
    #     GetDirectionsService.run!(start_loc: self.driver.home_address, end_loc: self.driver.pick_up_at)
    # end
end
