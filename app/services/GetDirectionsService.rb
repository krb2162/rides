class GetDirectionsService
    class << self
        def run!(start_address:, end_address:)
            #if this is in route then return stored data
            route = Route.find_by(pick_up_address: start_address, destination: end_address)

            if route.nil?
                response = Google::Maps.route(start_address, end_address)
                #FIXME: want pick up at and destination to be start_address and end_address
                #FIXME: refactor of the service, move formatting to methods, maybe memoize the response? make an instance variable?
                route = Route.create!(pick_up_address: start_address,
                    destination: end_address,
                    time_minutes: response.duration.value / 60.0,
                    distance_miles: response.distance.text.split(" ").first)
            end

            route.id #TODO: or route object if it works?
        end
    end
end