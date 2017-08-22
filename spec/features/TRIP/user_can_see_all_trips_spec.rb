RSpec.describe "user can see all trips" do
  it "when visiting trips index" do
    Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 69, end_station_id: 666, bike_id: 666, subscription_type: "customer")
    Trip.create(duration: 60000, start_date: "1969/5/20", end_date: "1969/6/20", start_station_id: 69, end_station_id: 66, bike_id: 69, subscription_type: "subscriber")

    visit '/trips'

    expect(page).to have_content("customer")
    expect(page).to have_content("subscriber")
    expect(Trip.count).to eq(2)
  end
end
