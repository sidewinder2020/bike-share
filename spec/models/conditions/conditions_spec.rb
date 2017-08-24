RSpec.describe "Condition" do
	describe "Validataions" do
		it "Can exist with valid attributes" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
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
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a min temperature" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														    mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a max temperature" do
			condition = Condition.create(weather_date: "1991/8/14",
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean temperature" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,
																	 mean_humidity: 20.1,     mean_visibility: 2,
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
																	 zip_code: 80113                                )
			expect(Condition.count).to eq(0)
		end

		it "Can't be created without a mean humidity" do
			condition = Condition.create(weather_date: "1991/8/14", max_temperature: 50.1,
			 														 min_temperature: 40.1,   mean_temperature: 45.3,
																	     mean_visibility: 2,
																	 mean_wind_speed: 9.0,      precipitation: 3.1,
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
	describe "Weather Analytics" do
		describe "breakout_temp" do
			it "returns range of trips for temperature ranges" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 30.0,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9,      precipitation: 3.1,zip_code: "80113")
			 trip_1 = condition.trips.create!(duration: 600, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				expect(Condition.breakout(40.0)[:min]).to eq(3)
				expect(Condition.breakout(40.0)[:max]).to eq(3)
				expect(Condition.breakout(40.0)[:avg]).to eq(3)
			end
			
			it "returns all trips in 10 degree increments" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.0,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9,      precipitation: 3.1,zip_code: "80113")
			 trip_1 = condition.trips.create!(duration: 600, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1991/8/14", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				temp_hash = {40.0=>{:min=>3,:max=>3,:avg=>3},50.0=>{:min=>0,:max=>0,:avg=>0},60.0=>{:min=>0,:max=>0,:avg=>0},
										70.0=>{:min=>0,:max=>0,:avg=>0},80.0=>{:min=>0,:max=>0,:avg=>0},90.0=>{:min=>0,:max=>0,:avg=>0}}
													 
				expect(Condition.breakout_temps).to eq(temp_hash)
			end
		end
			
		describe "breakout_precip" do
			it "returns ranges of trips for precipitation ranges" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9,      precipitation: 3.1,zip_code: "80113")
			 trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				expect(Condition.breakout_inches(3.0)[:min]).to eq(3)
				expect(Condition.breakout_inches(3.0)[:max]).to eq(3)
				expect(Condition.breakout_inches(3.0)[:avg]).to eq(3)
			end
			
			it "returns range of all trips for each .5in increment of precipitation" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9,      precipitation: 3.1,zip_code: "80113")
			 trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				precip_hash ={0.0=>{:min=>0, :max=>0, :avg=>0},0.5=>{:min=>0, :max=>0, :avg=>0},1.0=>{:min=>0, :max=>0, :avg=>0},
											1.5=>{:min=>0, :max=>0, :avg=>0},2.0=>{:min=>0, :max=>0, :avg=>0}, 2.5=>{:min=>0, :max=>0, :avg=>0},
											3.0=>{:min=>3, :max=>3, :avg=>3}}
											 
				expect(Condition.breakout_precip).to eq(precip_hash)
			end
		end
		
		describe ".wind_speed_trips" do
			it "returns analytics for trips on days with mean wind speed" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
				condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
					 														 min_temperature: 40.1,   mean_temperature: 45.3,
																			 mean_humidity: 20.1,     mean_visibility: 2,
																			 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
			 	trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
						
				expect(Condition.breakout_mph(8.0)[:min]).to eq(1)
				expect(Condition.breakout_mph(8.0)[:max]).to eq(3)
				expect(Condition.breakout_mph(8.0)[:avg]).to eq(2)
			end
			
			it "returns trips that occured on days with windspeed in 4mph increments" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
																		 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2,
																		 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
				condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
																			 min_temperature: 40.1,   mean_temperature: 45.3,
																			 mean_humidity: 20.1,     mean_visibility: 2,
																			 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
				trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
				speed_hash = {0.0=>{:min=>0, :max=>0, :avg=>0}, 4.0=>{:min=>0, :max=>0, :avg=>0},
				 							8.0=>{:min=>1, :max=>3, :avg=>2}, 12.0=>{:min=>0, :max=>0, :avg=>0}}
				
				expect(Condition.breakout_speed).to eq(speed_hash)
			end
		end
		
		describe ".sight_dist_trips" do
			it "returns analytics for trips on days with mean visibilityin 4mi increments" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2.0,
																		 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
				condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
					 														 min_temperature: 40.1,   mean_temperature: 45.3,
																			 mean_humidity: 20.1,     mean_visibility: 3.0,
																			 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
			 	trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
						
				expect(Condition.breakout_sight(0.0)[:min]).to eq(1)
				expect(Condition.breakout_sight(0.0)[:max]).to eq(3)
				expect(Condition.breakout_sight(0.0)[:avg]).to eq(2)
			end
			
			# it "returns all trips on days based on visibility in 4mi increments" do
			# 	condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
			# 															 min_temperature: 40.1,   mean_temperature: 45.3,
			# 															 mean_humidity: 20.1,     mean_visibility: 2.0,
			# 															 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
			# 	condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
			# 																 min_temperature: 40.1,   mean_temperature: 45.3,
			# 																 mean_humidity: 20.1,     mean_visibility: 3.0,
			# 																 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
			# 	trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
			# 										 start_station_id: 1, end_station_id: 2, bike_id: 4,
			# 										 subscription_type: "Some Nonsense", zip_code: "80113")
			# 
			# 	trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
			# 										 start_station_id: 1, end_station_id: 2, bike_id: 4,
			# 										 subscription_type: "Some Nonsense", zip_code: "80113")
			# 
			# 
			# 	trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
			# 										 start_station_id: 1, end_station_id: 2, bike_id: 4,
			# 										 subscription_type: "Some Nonsense", zip_code: "80113")
			# 										 
			# 	trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
			# 										 start_station_id: 1, end_station_id: 2, bike_id: 4,
			# 										 subscription_type: "Some Nonsense", zip_code: "80113")
			# 	sight_hash = {}
			# 	expect(Condition.breakout_view).to eq(sight_hash)
			# end
		end
		
		describe ".best_weather_trip_day" do
			it "returns weather for day with most rides" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2.0,
																		 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
				condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
					 														 min_temperature: 40.1,   mean_temperature: 45.3,
																			 mean_humidity: 20.1,     mean_visibility: 3.0,
																			 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
			 	trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
						
				expect(Condition.best_weather_trip_day.id).to eq(1)
			end
		end
		
		describe ".worst_weather_trip_day" do
			it "returns weather for day with fewest rides" do
				condition = Condition.create!(weather_date: "1991/8/14", max_temperature: 40.0,
				 														 min_temperature: 40.1,   mean_temperature: 45.3,
																		 mean_humidity: 20.1,     mean_visibility: 2.0,
																		 mean_wind_speed: 9.0,      precipitation: 3.1,zip_code: "80113")
				condition_2 = Condition.create!(weather_date: "1991/8/15", max_temperature: 40.0,
					 														 min_temperature: 40.1,   mean_temperature: 45.3,
																			 mean_humidity: 20.1,     mean_visibility: 3.0,
																			 mean_wind_speed: 10.0,      precipitation: 3.1,zip_code: "80113")
			 	trip_1 = condition.trips.create!(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")

				trip_2 = condition.trips.create!(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")


				trip_3 = condition.trips.create!(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
													 
				trip_4 = condition_2.trips.create!(duration: 180000, start_date: "1991/8/15", end_date: "1991/8/15",
													 start_station_id: 1, end_station_id: 2, bike_id: 4,
													 subscription_type: "Some Nonsense", zip_code: "80113")
						
				expect(Condition.worst_weather_trip_day.id).to eq(2)
			end
		end
	end
end
