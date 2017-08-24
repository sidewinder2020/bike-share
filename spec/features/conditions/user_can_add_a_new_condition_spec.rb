RSpec.describe "User can create a new condition" do
	it "When visiting condition index" do

		visit "/conditions/new"



		fill_in('weather_date',    with: '1969/4/20')
		fill_in('min_temperature', with: "10.0"       )
		fill_in('max_temperature', with: "100.0"      )
		fill_in('mean_temperature',with: "20.0"       )
		fill_in('mean_humidity',   with: "20.0"       )
		fill_in('mean_wind_speed', with: "3.5"        )
		fill_in('mean_visibility', with: "2.0"          )
		fill_in('precipitation',   with: "2.25"       )
		fill_in('zip_code',        with: "95113"      )

		click_on('Create new condition')

		expect(Condition.count).to eq(1)

		# condition = Condition.all.first
		# expect(current_path).to eq("/conditions")
		# expect(condition.max_temperature).to eq(100.0)
		# expect(condition.min_temperature).to eq(10.0)
		# expect(condition.mean_temperature).to eq(20.0)
		# expect(condition.mean_humidity).to eq(20.0)
		# expect(condition.weather_date).to eq(Date.parse('1969/4/20'))
		# expect(condition.mean_wind_speed).to eq(3.5)
		# expect(condition.mean_visibility).to eq(2)
		# expect(condition.precipitation).to eq(2.25)
		# expect(condition.zip_code).to eq(80113)


	end
end
