class Route < ApplicationRecord
    has_many :rides

    validates_presence_of :start_address, :end_address, :time_minutes, :distance_miles
    validates :time_minutes, numericality: { greater_than_or_equal_to: 0 }
    validates :distance_miles, numericality: { greater_than_or_equal_to: 0 }
    #TODO: select and implement an address validation with an address gem

    # coupled with business logic, so extrapolated to constants for ease of adjustment
    MILES_THRESHOLD = 5 
    MINUTES_THRESHOLD = 15

    ADDITIONAL_MILES_PAY = 1.5
    ADDITIONAL_MINUTES_PAY = 0.7
    BASE_PAY = 12

    def earnings
        BASE_PAY + (ADDITIONAL_MILES_PAY * extra_miles) + (ADDITIONAL_MINUTES_PAY * extra_time)
    end

    def extra_miles
        distance_miles > MILES_THRESHOLD ? distance_miles - MILES_THRESHOLD : 0
    end

    def extra_time
        time_minutes > MINUTES_THRESHOLD ? time_minutes - MINUTES_THRESHOLD : 0
    end
end
