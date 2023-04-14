require 'rails_helper'

RSpec.describe Ride, type: :model do
    let(:address) { "50123 Blueberry Lane, Santa Cruz, CA" }
    let(:driver) { create(:driver, home_address: address) }
    
    let(:ride) { create(:ride, pick_up_at: Time.zone.tomorrow ) }
    let(:ride_2) { create(:ride, pick_up_at: Time.zone.tomorrow) }
    let(:ride_3) { create(:ride, pick_up_at: Time.zone.yesterday) }

	# describe "relationships" do
    #     it { should belong_to(:driver).optional }
    #     it { should belong_to(:ride) }
	# end

    describe "validations" do
        context "pick up at" do
            it "is not valid without the presence of pick up at" do
                ride.pick_up_at = nil
                expect(ride).to_not be_valid
            end
            
            it "is valid with presence of pick up at" do
                expect(ride).to be_valid
            end
        end
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
    end
end
