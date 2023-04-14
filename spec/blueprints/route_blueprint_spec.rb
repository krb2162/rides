require 'rails_helper'

RSpec.describe RouteBlueprint do
    let(:route) { create(:route) }
    
    describe "::render_as_hash" do
        it "includes all necessary values" do
            hash = described_class.render_as_hash(route)
            expect(hash).to eq(
                id: route.id,
                start_address: route.start_address,
                end_address: route.end_address,
                time_minutes: route.time_minutes,
                distance_miles: route.distance_miles
            )
        end
    end
end