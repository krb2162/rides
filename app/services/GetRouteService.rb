class GetRouteService
    class << self
        def run!(start_address:, end_address:)
            route = Route.find_by(pick_up_address: start_address, destination_address: end_address)

            if route.nil?
                response = Google::Maps.route(start_address, end_address)
                #FIXME: want pick up at and destination to be start_address and end_address

                route = Route.create!(pick_up_address: start_address,
                    destination_address: end_address,
                    time_minutes: response.duration.value / 60.0,
                    distance_miles: response.distance.text.split(" ").first)
            end

            route
        end
    end
end