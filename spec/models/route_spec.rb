require 'rails_helper'

RSpec.describe Route, type: :model do
	describe "relationships" do
		it { should have_many(:rides) }
	end

	describe 'scopes' do
	end

	describe 'instance methods' do
	end
end
