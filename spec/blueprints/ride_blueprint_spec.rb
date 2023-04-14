require 'rails_helper'

RSpec.describe RideBlueprint do
    let(:ride) { create(:ride) }
    
    describe "::render_as_hash" do
        it "includes all necessary values" do
            hash = described_class.render_as_hash(ride)
            expect(hash).to eq(
                id: ride.id,
                pick_up_at: ride.pick_up_at,
                driver_id: ride.driver_id
            )
        end
    end

    context 'extended view' do
        it 'contains the associated route' do
            hash = described_class.render_as_hash(ride, view: :extended)

            expect(hash[:route])
                .to eq(RouteBlueprint.render_as_hash(ride.route))
        end
    end
end