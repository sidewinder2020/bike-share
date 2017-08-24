RSpec.describe "While visiting condition show page" do
	it "a user can delete a condition" do
		Condition.create(weather_date: "1969/4/20", min_temperature: 30.0, mean_temperature: 40.0,
		 								 max_temperature: 50.0, mean_humidity: 30.0, mean_visibility: 95.0,
										 mean_wind_speed: 8.0, precipitation: 0.1, zip_code: 95113                      )
		visit "/conditions"

		expect(Condition.count).to eq(1)
		click_on('Delete')
		expect(Condition.count).to eq(0)

	end
end
