require 'rails_helper'

RSpec.describe "Rides", type: :request do
    
    describe "index route" do
        let(:driver) { create(:driver) }
        let(:route) { create(:route, time_minutes: 200, distance_miles: 200) }
        let(:route2) { create(:route, time_minutes: 2, distance_miles: 2) }

        let!(:taken_ride) { create(:ride, pick_up_at: Time.zone.tomorrow, driver_id: driver.id) }
        let!(:past_ride) { create(:ride, pick_up_at: Time.zone.yesterday, driver_id: nil) }
        let!(:future_available_ride) { create(:ride, pick_up_at: Time.zone.tomorrow, driver_id: nil, route_id: route.id) }
        let!(:future_available_ride_2) { create(:ride, pick_up_at: Time.zone.tomorrow, driver_id: nil, route_id: route2.id) }

        it 'makes a successful request' do
            get "/rides/:#{driver.id}"
            expect(response).to be_successful
        end

        context 'no filter param' do
            it 'returns all rides' do
                get "/rides/:#{driver.id}"
                res = JSON.parse(response.body)

                expect(res.length).to eq(4)
            end
        end

        context 'filter param is score' do
            it 'returns future, available rides' do 
                get "/rides/:#{driver.id}", :params => {:filter => 'score'}

                res = JSON.parse(response.body)
                expect(res.first["id"]).to eq(future_available_ride.id)
            end

            it 'returns in score descending' do 
                get "/rides/:#{driver.id}", :params => {:filter => 'score'}
                res = JSON.parse(response.body)
                
                expect(res.length).to eq(2)

                higher_scoring_ride = Ride.find(res.first["id"])
                lower_scoring_ride = Ride.find(res.last["id"])

                expect(higher_scoring_ride.route).to eq(route) 
                expect(lower_scoring_ride.route).to eq(route2) 
            end
        end
    end
end