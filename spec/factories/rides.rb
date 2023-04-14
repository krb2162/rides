FactoryBot.define do
	factory :ride do
        route
		pick_up_at { Time.zone.now }
	end
end
