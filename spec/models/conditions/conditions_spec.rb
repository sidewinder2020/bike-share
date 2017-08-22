RSpec.describe "Condition" do
	describe "Validataions" do
		it "Can exist with valid attributes" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(condition.weather_date).to eq(Date.parse("1991/8/14"))
			expect(condition.max_temperature).to eq(50.1)
			expect(condition.min_temperature).to eq(40.1)
			expect(condition.mean_temperature).to eq(45.3)
			expect(condition.mean_humidity).to eq(20.1)
			expect(condition.mean_visibility).to eq(2)
			expect(condition.mean_wind_speed).to eq(9)
			expect(condition.precipitation).to eq(3.1)
			expect(condition.zip_code).to eq("80113")
		end
	end
	describe "In-validations" do
		it "Can't be created without a date" do
			condition = Condition.create(max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a min temperature" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														    mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a max temperature" do
			condition = Condition.create(weather_date: "1991/8/14",
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean temperature" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean humidity" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean visibility" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,
																	 mean_wind_speed: 9,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean wind speed" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	       precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a precipitation" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a zip code" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9,      precipitation: 3.1      )
			expect(Condition.count).to eq(0)
		end

	end
end
