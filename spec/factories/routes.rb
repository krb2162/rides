FactoryBot.define do
	factory :route do
		time_minutes { 10 }
		distance_miles { 100 }
		start_address { "33333 S. Pacific Coast Hwy."}
		end_address { "887 S Anaheim Blvd, Anaheim, CA 92805" }
	end
end
