require 'rails_helper'

RSpec.describe GetRouteService do
    let(:start_location) { "20 W 34th St., New York, NY 10001" }
    let(:end_location) { "253 W 125th St, New York, NY 10027" }
    let(:route) { create(:route, start_address: start_location, end_address: end_location) }
    # let(:response) { Google::Maps.route(start_location, end_location) }

    describe '#run!' do
        let(:number_of_routes) { Route.count }

        context 'given a start location and end location of an existing route' do
            it 'should find and return the existing route' do
                route

                expect { described_class.run!(start_address: start_location, end_address: end_location) }
                    .not_to change { Route.count }

                returned_route = described_class.run!(start_address: start_location, end_address: end_location) 

                expect(returned_route).to eq(route)
            end
        end

        context 'given a start location and end location pair not matching an existing route' do
            it 'should create and return a new route with formatted fields' do
                start_route_count = Route.count

                VCR.use_cassette('google_maps_route/sucess') do
                    response = described_class.run!(start_address: start_location, end_address: end_location) 
                    expect(response).to eq(Route.last)

                    expect(Route.count).to eq(start_route_count + 1)

                    expect(response.time_minutes.class).to eq(Integer)
                    expect(response.distance_miles.class).to eq(Integer)
                    expect(response.start_address).to eq(start_location)
                    expect(response.end_address).to eq(end_location)
                end
            end
        end
    end
end