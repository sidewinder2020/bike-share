RSpec.describe "User can see a specific station" do
	it "When visiting station / station id" do
		Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
		Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 1, end_station_id: 1, bike_id: 666, subscription_type: "customer")


		visit 'stations/1'

		page.has_content?("Turing")
		page.has_content?("Hell")
	end
end
