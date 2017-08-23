RSpec.describe "User can delete a trip" do
  it "when clicking delete on a trip" do
    Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 1, end_station_id: 1, bike_id: 666, subscription_type: "customer")
    Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)

    visit "/trips"
    click_on("Delete")

    expect(Trip.count).to eq(0)
  end
end
