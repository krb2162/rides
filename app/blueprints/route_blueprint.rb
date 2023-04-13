class RouteBlueprint < Blueprinter::Base
    identifier :id

    fields :start_address,
           :end_address,
           :time_minutes,
           :distance_miles
end