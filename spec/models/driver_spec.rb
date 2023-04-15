require 'rails_helper'

RSpec.describe Driver, type: :model do
	describe "relationships" do
        it { should have_many(:rides) }
	end

    describe "validations" do
	    it { should validate_presence_of(:home_address) }
    end
end
