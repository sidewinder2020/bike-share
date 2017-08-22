require 'Date'

RSpec.describe Trip do
	describe "Validations" do
		it "can exist with valid attributes" do
      trip = Trip.create(duration: 4002, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113"          )

      expect(trip.duration).to eq(4002)
      expect(trip.start_date).to eq(Date.parse("1969/4/20"))
      expect(trip.end_date).to eq(Date.parse("1969/4/21"))
      expect(trip.start_station_id).to eq(1)
			expect(trip.end_station_id).to eq(2)
			expect(trip.bike_id).to eq(4)
			expect(trip.subscription_type).to eq("Some Nonsense")
			expect(trip.zip_code).to eq("80113")


			expect(Trip.count).to eq(1)
		end
	end

	describe "In-Validations" do
		it "Is invalid without a duration" do
			trip = Trip.create(start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113"          )
			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a start date" do
			trip = Trip.create(duration: 4002, end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113"          )

			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a end date" do
			trip = Trip.create(duration: 4002, start_date: "1969/4/20",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113"          )

			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a start station id" do
			trip = Trip.create(duration: 4002, start_date: "1969/4/20", end_date: "1969/4/21" ,
			 										end_station_id: 2, bike_id: 4, subscription_type: "Some Nonsense",
													zip_code: "80113")

			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a end station id" do
			trip = Trip.create(duration: 4002, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113"          )

			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a bike id" do
			trip = Trip.create(duration: 4002, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2,
												 subscription_type: "Some Nonsense", zip_code: "80113"          )

			expect(Trip.count).to eq(0)
		end

		it "Is invalid without a subscription type" do
			trip = Trip.create(duration: 4002, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4, zip_code: "80113")

			expect(Trip.count).to eq(0)
		end
	end

	describe "Class Methods" do
		it "Gets the average duration of a ride" do
			trip_1 = Trip.create(duration: 60, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 120, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")


			avg_trip_duration = Trip.average_duration_of_a_trip

			expect(avg_trip_duration).to eq("02:00")
		end

		it "Gets the longest ride" do
			trip_1 = Trip.create(duration: 660, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
			 									 subscription_type: "Some Nonsense", zip_code: "80113")

			long_trip = trip_3.duration
			long_trip_convert = Trip.time_converter(long_trip)

			expect(long_trip_convert).to eq("2 days")
			expect(Trip.longest_ride).to eq("2 days")
		end

		it "Gets the shortest ride" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			quickest_trip = trip_1.duration
			quickest_trip_convert = Time.at(quickest_trip).utc.strftime("%M:%S")

			expect(quickest_trip_convert).to eq("10:00")
			expect(Trip.shortest_ride).to eq("10:00")
		end

		it "Gets the station with the most rides as a starting place" do
			station_one   = Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
			station_two   = Station.create(name: "Mushroom", city: "Englewood", installation_date: "1982/3/10", dock_count: 413)

			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			expect(Station.most_popular_starting_station).to eq(station_one.name)
		end

		it "Gets the station with the most rides as an ending place" do
			station_one   = Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
			station_two   = Station.create(name: "Mushroom", city: "Englewood", installation_date: "1982/3/10", dock_count: 413)

			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			expect(Station.most_popular_ending_station).to eq(station_two.name)
		end

		it "Gets the monthly and yearly ride breakdown" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			expect(Trip.monthly_ride_breakdown.values).to eq([3])
			expect(Trip.yearly_ride_breakdown.values).to eq([3])
		end

		it "Gets the most ridden bike" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 5,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			expect(Trip.hottest_bike).to eq("Bike 4 is the hottest bike with 2 times ridden")
		end

		it "Gets the least ridden bike" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Some Nonsense", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 5,
												 subscription_type: "Some Nonsense", zip_code: "80113")

			expect(Trip.most_neglected_bike).to eq("Bike 5 is the least popular bike with only 1 times ridden")
		end

		it "Gets subscription type breakdown" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 5,
												 subscription_type: "Subscriber", zip_code: "80113")

			breakdown = "There are 1 subscriber trips representing 33.33% of the total. There are 2 customer trips representing 66.67% of total trips."

			expect(Trip.subscription_type_breakdown).to eq(breakdown)
		end

		it "Gets most popular trip date" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/21", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 5,
												 subscription_type: "Subscriber", zip_code: "80113")

			breakdown = "1969-04-20 was the most popular trip date, with 2 rentals."

			expect(Trip.most_popular_trip_date).to eq(breakdown)
		end

		it "Gets least popular trip date" do
			trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")

			trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
												 start_station_id: 1, end_station_id: 2, bike_id: 4,
												 subscription_type: "Customer", zip_code: "80113")


			trip_3 = Trip.create(duration: 180000, start_date: "1969/4/21", end_date: "1969/4/21",
												 start_station_id: 2, end_station_id: 1, bike_id: 5,
												 subscription_type: "Subscriber", zip_code: "80113")

			breakdown = "1969-04-21 was the least popular trip date, with only 1 rentals."

			expect(Trip.least_popular_trip_date).to eq(breakdown)
		end

	end
end
