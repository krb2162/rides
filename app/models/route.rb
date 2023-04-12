class Route < ApplicationRecord
    has_many :rides

    MILES_THRESHOLD = 5
    MINUTES_THRESHOLD = 15

    def earnings
        12 + (1.5 * extra_miles) + (0.7 * extra_time)
    end

    def extra_miles
        #what to do here if the value isn't made yet? say API went down?
        distance_miles > MILES_THRESHOLD ? distance_miles - MILES_THRESHOLD : 0
    end

    def extra_time
        time_minutes > MINUTES_THRESHOLD ? time_minutes - MINUTES_THRESHOLD : 0
    end
end
