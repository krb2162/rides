require 'rails_helper'

RSpec.describe GetRouteService do
    let(:route) { create(:route) }

    describe '#run!' do
        context 'given a start location and end location of an existing route' do
            it 'should find and return the existing route' do
            end
        end

        context 'given a start location and end location pair not in an existing route' do
            it 'should create a new route' do
            end

            it 'should get the time and distance from google maps' do
            end

            it 'should accurately populate the route fields' do
            end
        end
    end
end