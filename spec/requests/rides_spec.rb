require 'rails_helper'

RSpec.describe "Rides", type: :request do

    describe "request all rides in order of the driver's highest scoring (descending)" do
        let(:driver) { create(:driver) }
        
        let(:taken_ride) { create(:ride, pick_up_at: Time.zone.tomorrow, driver_id: driver.id) }
        let(:past_ride) { create(:ride, pick_up_at: Time.zone.yesterday, driver_id: nil) }
        let(:future_available_ride) { create(:ride, pick_up_at: Time.zone.tomorrow, driver_id: nil) }

        it 'makes successful request' do
            get "/rides/:#{driver.id}"
            expect(response).to be_successful
        end

        it 'returns future, available rides only' do
            taken_ride
            past_ride
            future_available_ride

            get "/rides/:#{driver.id}"

            res = JSON.parse(response.body)

            expect(res.length).to eq(1)
            expect(res.first["id"]).to eq(future_available_ride.id)
        end
    end
end