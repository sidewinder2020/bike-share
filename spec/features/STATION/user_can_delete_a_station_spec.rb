RSpec.describe "User can delete Stations" do
	it "When clicking delete on a station" do
		Station.create(name: "Turing", city: "Hell", installation_date: "1969/4/20", dock_count: 69)

		visit "/stations"
		click_on("Delete")

		expect(Station.count).to eq(0)
	end
end
