class RideBlueprint < Blueprinter::Base
    identifier :id

    fields :driver_id,
           :pick_up_at

    view :extended do
        association :route, blueprint: RouteBlueprint
    end
end