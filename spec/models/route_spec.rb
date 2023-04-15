require 'rails_helper'

RSpec.describe Route, type: :model do
    # let(:driver) { create(:driver) }
    
    # let(:ride) { create(:ride, pick_up_at: Time.zone.tomorrow ) }
    # let(:ride_2) { create(:ride, pick_up_at: Time.zone.tomorrow) }
    # let(:ride_3) { create(:ride, pick_up_at: Time.zone.yesterday) }

    # let(:route) { create(:route, time_minutes: 10, distance_miles: 8) }

	# describe "relationships" do
    #     it { should belong_to(:driver).optional }
    #     it { should belong_to(:ride) }
	# end
	describe "constants" do
		it "should have the correct miles threshold value" do
			expect(Route::MILES_THRESHOLD).to eq(5)
		end

		it "should have the correct minutes threshold value" do
			expect(Route::MINUTES_THRESHOLD).to eq(15)
		end

		it "should have the correct additional minutes pay value" do
			expect(Route::ADDITIONAL_MINUTES_PAY).to eq(0.7)
		end

		it "should have the correct additional miles pay value" do
			expect(Route::ADDITIONAL_MILES_PAY).to eq(1.5)
		end
	end

    describe "validations" do
        # context "pick up at" do
        #     it "is not valid without the presence of pick up at" do
        #         ride.pick_up_at = nil
        #         expect(ride).to_not be_valid
        #     end
            
        #     it "is valid with presence of pick up at" do
        #         expect(ride).to be_valid
        #     end
        # end
    end

    describe "methods" do
        context "#earnings" do
            # it "handles nil driver" do
            #     ride.update!(driver_id: nil)
            #     expect(ride.score).to eq(nil)
            # end
            
            # it "gets the correct score for a ride" do
            #     expect(GetRouteService).to receive(:run!).and_return(route)
            #     ride.update!(route_id: route.id)

            #     # route is 10 minutes, 8 miles; commute is 10 minutes
            #         # earnings = 12 + (3 * 1.5) + (0 * 0.7) == 16.5
            #         # 16.5 / (10/60.0 + 10/60.0) == 49.5
                
            #     expect(ride.score).to eq(49.5)
            # end
        end

        context "#extra_time" do
        end

        context "#extra_miles" do
            # it "handles nil driver" do
            #     ride.update!(driver_id: nil)
            #     expect(ride.commute_time).to eq(nil)
            # end

            # it "gets the commute time in minutes for a driver" do
            #     expect(GetRouteService).to receive(:run!).and_return(route)

            #     expect(ride.commute_time).to eq(route.time_minutes)
            # end
        end
    end
end