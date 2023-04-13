class RouteBlueprint < Blueprinter::Base
    identifier :id

    fields :pick_up_address,
           :destination_address,
           :time_minutes,
           :distance_miles
end