RSpec.describe "user can view trip analytics" do
  before do
    station_one   = Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
    station_two   = Station.create(name: "Mushroom", city: "Englewood", installation_date: "1982/3/10", dock_count: 413)

    trip_1 = Trip.create(duration: 600, start_date: "1969/4/20", end_date: "1969/4/21",
                       start_station_id: 1, end_station_id: 2, bike_id: 4,
                       subscription_type: "Customer", zip_code: "80113")

    trip_2 = Trip.create(duration: 1200, start_date: "1969/4/20", end_date: "1969/4/21",
                       start_station_id: 1, end_station_id: 2, bike_id: 4,
                       subscription_type: "Customer", zip_code: "80113")


    trip_3 = Trip.create(duration: 180000, start_date: "1969/4/20", end_date: "1969/4/21",
                       start_station_id: 2, end_station_id: 1, bike_id: 3,
                       subscription_type: "Subscriber", zip_code: "80113")

    visit("/trips-dashboard")

    end


  it "sees average duration of a ride" do
    average_trip = "50:00 minutes"

    expect(page).to have_content(average_trip)
    expect(page).to have_content(Trip.average_duration_of_a_trip)
  end

  it "sees longest ride" do
    expect(page).to have_content("2 days")
    expect(page).to have_content(Trip.longest_ride)
  end

  it "sees shortest ride" do
    expect(page).to have_content("10:00")
    expect(page).to have_content(Trip.shortest_ride)
  end

  it "sees the station with the most rides started there" do
    expect(page).to have_content("Turing")
    expect(page).to have_content(Station.most_popular_starting_station)
  end

  it "sees the station with the most rides ended there" do
    expect(page).to have_content("Mushroom")
    expect(page).to have_content(Station.most_popular_ending_station)
  end

  it "sees the monthly and yearly ride breakdown" do
    # skip
    # require 'pry'; binding.pry
    expect(page).to have_content("1969-04-01 00:00:00 UTC=>3")
    expect(page).to have_content("1969-01-01 00:00:00 UTC=>3")
  end

  it "sees the most ridden bike" do
    expect(page).to have_content("Bike 4 is the hottest bike with 2 times ridden")
    expect(page).to have_content(Trip.hottest_bike)
  end

  it "sees the least ridden bike" do
    expect(page).to have_content("Bike 3 is the least popular bike with only 1 times ridden")
    expect(page).to have_content(Trip.most_neglected_bike)
  end

  it "sees subscriber type breakdown" do
    breakdown = "There are 1 subscriber trips representing 33.33% of the total. There are 2 customer trips representing 66.67% of total trips."

    expect(page).to have_content(breakdown)
    expect(page).to have_content(Trip.subscription_type_breakdown)
  end

  it "sees the most popular trip date" do
    most_popular_date = "1969-04-20 was the most popular trip date, with 3 rentals."

    expect(page).to have_content(most_popular_date)
    expect(page).to have_content(Trip.most_popular_trip_date)
  end

  it "sees the least popular trip date" do
    least_popular_date = "1969-04-20 was the least popular trip date, with only 3 rentals."

    expect(page).to have_content(least_popular_date)
    expect(page).to have_content(Trip.least_popular_trip_date)
  end
end
