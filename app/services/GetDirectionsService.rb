class GetDirectionsService
    class << self
        def run!(start_address:, end_address:)
            #if this is in route then return stored data
            route = Route.find_by(pick_up_at: start_address, destination: end_address)

            if route.nil?
                # make call to lib 
                # add route details 
                #FIXME: want pick up at and destination to be start_address and end_address
                route = Route.create!(pick_up_at: start_address,
                    destination: end_address,
                    time_minutes: time_minutes,
                    distance_miles: distance_miles)
            end

            route.id #TODO: or route object if it works?
        end
    end
end