FactoryBot.define do
	factory :ride do
        route
        driver
		pick_up_at { Time.zone.now }
	end
end
