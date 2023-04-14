require 'rails_helper'

RSpec.describe Driver, type: :model do
    let(:address) { "50123 Blueberry Lane, Santa Cruz, CA" }
    let(:driver) { create(:driver, home_address: address) }
    let!(:ride) { create(:ride, driver_id: driver.id) }

	describe "relationships" do
        it "should have many rides when associated to rides" do
            expect(driver.rides.count).to eq(1)
        end
	end

    describe "validations" do
        context "home address" do
            it "is not valid without the presence of home address" do
                driver.home_address = nil
                expect(driver).to_not be_valid
            end
            
            it "is valid with presence of home address" do
                expect(driver).to be_valid
            end
        end
    end
end
