RSpec.describe "User can update a station" do
	it "when visiting a station's edit page" do
	Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)
	Trip.create(duration: 40000, start_date: "1969/4/20", end_date: "1969/4/20", start_station_id: 1, end_station_id: 1, bike_id: 666, subscription_type: "customer")


	visit '/stations'
	click_on('Edit')
	expect(page).to have_content("Edit your Station")

	fill_in('station[name]',              with: 'Mushroom')
	fill_in('station[city]',              with: 'Englewood')
	fill_in('station[installation_date]', with: '2012/1/1' )
	fill_in('station[dock_count]',        with: "20"       )

	click_on('edit the station')
	expect(current_path).to eq("/stations/1")

	end
end
