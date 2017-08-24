RSpec.describe "User can create a new station" do
	it "When visiting new station" do

		visit '/stations/new'


		fill_in('name',              with: 'Mushroom' )
		fill_in('city',      				with: 'Englewood')
		fill_in('installation_date', with: '2012/1/1' )
		fill_in('dock_count',        with: "20"       )


		click_on('Create this Station')
		station = Station.all.first

		expect(current_path).to eq("/stations")
		expect(station.name).to eq('Mushroom')
		expect(station.city).to eq('Englewood')
		expect(station.installation_date).to eq(Date.parse('2012/1/1'))
		expect(station.dock_count).to eq(20)
	end
end
