require 'rails_helper'

RSpec.describe Route, type: :model do
    let(:route) { create(:route) }

	# describe "relationships" do
    #     it { should belong_to(:driver).optional }
    #     it { should belong_to(:ride) }
	# end
	describe "constants" do
		it "should have the correct base pay value" do
			expect(Route::BASE_PAY).to eq(12)
		end

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
            it "returns the correct earnings for a route" do
				route.update!(distance_miles: 100, time_minutes: 75)
				# 12 + (1.5 * 95) + (0.7 * 60) == 196.5

                expect(route.earnings).to eq(196.5)
            end
        end

        context "#extra_time" do
			it "correctly calculates for a duration less than the threshold" do
				route.update!(time_minutes: Route::MINUTES_THRESHOLD - 1) # assume threshold > 0

				expect(route.extra_time).to eq(0)
			end

			it "correctly calculates for a duration greater than the threshold" do
				route.update(time_minutes: Route::MINUTES_THRESHOLD + 3)

				expect(route.extra_time).to eq(3)
			end
        end

        context "#extra_miles" do
			it "correctly calculates for a distance less than the threshold" do
				route.update!(distance_miles: Route::MILES_THRESHOLD - 1) # assume threshold > 0

				expect(route.extra_miles).to eq(0)
			end

			it "correctly calculates for a distance greater than the threshold" do
				route.update(distance_miles: Route::MILES_THRESHOLD + 3)

				expect(route.extra_miles).to eq(3)
			end
        end
    end
end