require 'rails_helper'

RSpec.describe Ride, type: :model do
    # let(:address) { "50123 Blueberry Lane, Santa Cruz, CA" }
    # let(:driver) { create(:driver, home_address: address) }
    let(:ride) { create(:ride, pick_up_at: Time.zone.now ) }

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
end
