RSpec.describe "User can create a new trip" do
  it "When visiting a new trip" do

    visit '/trips/new'

    fill_in('duration',           with:"4000789")
    fill_in('start_station_id',   with:'69')
    fill_in('end_station_id',     with:'666')
    fill_in('start_date',         with:'2012/1/1')
    fill_in('end_date',           with:'2012/1/2')
    fill_in('bike_id',            with:'4')
    select('Customer', :from => 'subscription_type')

    click_on('create new trip')
    trip = Trip.all.first

    expect(current_path).to eq("/trips")
    expect(trip.duration).to eq(4000789)
    expect(trip.start_station_id).to eq(69)
    expect(trip.end_station_id).to eq(666)
    expect(trip.start_date).to eq(Date.parse('2012/1/1'))
    expect(trip.end_date).to eq(Date.parse('2012/1/2'))
    expect(trip.bike_id).to eq(4)
    expect(trip.subscription_type).to eq('customer')
  end
end
