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

end
