RSpec.describe "User can see a specific trip" do
  it "when visiting trip / trip id" do
    Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 69, end_station_id: 666, bike_id: 666, subscription_type: "customer")

    visit 'trips/1'

    page.has_content?("customer")
    page.has_content?("666")
  end
end
