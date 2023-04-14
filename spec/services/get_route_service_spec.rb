require 'rails_helper'

RSpec.describe GetRouteService do
    let(:start_location) { "fake address 1" }
    let(:end_location) { "fake address 2" }
    let(:route) { create(:route, start_address: start_location, end_address: end_location) }

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
            it 'should create a new route' do
                pp number_of_routes
            end

            it 'should get the time and distance from google maps' do
            end

            it 'should accurately populate the route fields' do
            end
        end
    end
end