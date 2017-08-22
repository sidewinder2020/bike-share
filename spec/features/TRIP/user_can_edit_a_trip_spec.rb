RSpec.describe "User can edit a trip" do
  it "when user clicks on edit" do
  Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 69, end_station_id: 666, bike_id: 666, subscription_type: "customer")

    visit "/trips"
    click_on('Edit')
    expect(page).to have_content("Edit your Trip")

    fill_in('trip[start_station_id]',   with:"69")
    fill_in('trip[end_station_id]',     with:"666")
    fill_in('trip[start_date]',         with:'2012/1/1')
    fill_in('trip[end_date]',           with:'2012/1/2')
    fill_in('trip[duration]',           with:"4000789")
    fill_in('trip[bike_id]',            with:"4")
    select('Customer', :from => 'trip[subscription_type]')
    fill_in('trip[zip_code]',           with:'40506')

    click_on('edit the trip')
  	expect(current_path).to eq("/trips/1")
  end
end
