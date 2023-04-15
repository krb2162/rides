require 'rails_helper'

RSpec.describe Ride, type: :model do
    let(:driver) { create(:driver) }
    
    let(:ride) { create(:ride, pick_up_at: Time.zone.tomorrow ) }
    let(:ride_2) { create(:ride, pick_up_at: Time.zone.tomorrow) }
    let(:ride_3) { create(:ride, pick_up_at: Time.zone.yesterday) }

    let(:route) { create(:route, time_minutes: 10, distance_miles: 8) }

	describe "relationships" do
        it { should belong_to(:driver).optional }
        it { should belong_to(:route) }
	end

    describe "validations" do
		it { should validate_presence_of(:pick_up_at) }
    end

    describe "scopes" do
        context ".in_future" do
            it "only includes rides that have future pick up times" do
                expect(Ride.in_future).to include(ride)
                expect(Ride.in_future).to include(ride_2)
            end

            it "excludes rides that have past pick up times" do
                expect(Ride.in_future).to_not include(ride_3)
            end
        end

        context ".available" do
            it "includes rides that don't have a driver" do
                ride.update!(driver_id: nil)
                ride_2.update!(driver_id: driver.id)
                ride_3.update!(driver_id: driver.id)
                
                expect(Ride.available).to include(ride)
            end

            it "excludes rides that do have a driver" do
                ride.update!(driver_id: nil)
                ride_2.update!(driver_id: driver.id)
                ride_3.update!(driver_id: driver.id)
                
                expect(Ride.available).to_not include(ride_2)
                expect(Ride.available).to_not include(ride_3)
            end
        end
    end

    describe "methods" do
        context "#score" do
            it "handles nil driver" do
                ride.update!(driver_id: nil)
                expect(ride.score).to eq(nil)
            end
            
            it "gets the correct score for a ride" do
                expect(GetRouteService).to receive(:run!).and_return(route)
                ride.update!(route_id: route.id)

                # route is 10 minutes, 8 miles; commute is 10 minutes
                    # earnings = 12 + (3 * 1.5) + (0 * 0.7) == 16.5
                    # 16.5 / (10/60.0 + 10/60.0) == 49.5
                
                expect(ride.score).to eq(49.5)
            end
        end

        context "#commute_time" do
            it "handles nil driver" do
                ride.update!(driver_id: nil)
                expect(ride.commute_time).to eq(nil)
            end

            it "gets the commute time in minutes for a driver" do
                expect(GetRouteService).to receive(:run!).and_return(route)

                expect(ride.commute_time).to eq(route.time_minutes)
            end
        end
    end
end
