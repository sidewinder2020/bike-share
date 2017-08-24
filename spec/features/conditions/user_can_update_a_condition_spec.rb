RSpec.describe "While visiting condition show page" do
	it "a user can update a condition" do
		Condition.create(weather_date: "1969/4/20", min_temperature: 30.0, mean_temperature: 40.0,
		 								 max_temperature: 50.0, mean_humidity: 30.0, mean_visibility: 95.0,
										 mean_wind_speed: 8.0, precipitation: 0.1, zip_code: 95113                      )
		visit "/conditions/1/edit"

		fill_in('condition[weather_date]',    with: '1969/4/20')
		fill_in('condition[min_temperature]', with: 10.0       )
		fill_in('condition[max_temperature]', with: 100.0      )
		fill_in('condition[mean_temperature]',with: 20.0       )
		fill_in('condition[mean_humidity]',   with: 20.0       )
		fill_in('condition[mean_wind_speed]', with: 3.5        )
		fill_in('condition[mean_visibility]', with: 2          )
		fill_in('condition[precipitation]',   with: 2.25       )
		fill_in('condition[zip_code]',        with: 80113      )

		click_on('Submit')

		condition = Condition.all.first
		expect(current_path).to eq("/condition/1")
		expect(condition.max_temperature).to eq(100.0)
		expect(condition.min_temperature).to eq(10.0)
		expect(condition.mean_temperature).to eq(20.0)
		expect(condition.mean_humidity).to eq(20.0)
		expect(condition.weather_date).to eq(Date.parse('1969/4/20'))
		expect(condition.mean_wind_speed).to eq(3.5)
		expect(condition.mean_visibility).to eq(2)
		expect(condition.precipitation).to eq(2.25)
		expect(condition.zip_code).to eq("80113")
	end
end
