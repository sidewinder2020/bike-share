RSpec.describe "When user goes to the station id page, user can see" do
  it "number of rides started here" do
    station_a = Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
    station_b = Station.create(name: "Conjunction Junction", city: "Firenze", installation_date: "1984/7/21", dock_count: 40)
    station_c = Station.create(name: "SanFranSokyoeki", city: "Tokyo", installation_date: "1987/6/20", dock_count: 82)
  	Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 1, end_station_id: 2, bike_id: 666, subscription_type: "customer")
    Trip.create(duration: 60000, start_date: "1969/5/20", end_date: "1969/6/20", start_station_id: 1, end_station_id: 3, bike_id: 666, subscription_type: "customer")
    Trip.create(duration: 80000, start_date: "1969/6/20", end_date: "1969/7/20", start_station_id: 3, end_station_id: 1, bike_id: 777, subscription_type: "subscriber")


    visit '/stations/1'
    expect(page).to have_content(station_a.number_of_rides_started_here)
  end
end
