require './app/models/station.rb'
require './app/models/trip.rb'
require 'csv'
require 'time'
require 'Date'
require 'pry'

def delete_columns(path, column_headers)
  table = CSV.table(path)
  column_headers.each do |column_header|
    table.delete(column_header)
  end
  table
end

def clean_zipcode(zip_code)
  zip_code.to_s.rjust(5, "0")[0..4]
end

Station.destroy_all
# system 'Say "Good morning Joan, I love you, I will never leave you, destroy stations complete"'
Trip.destroy_all
# system 'Say "Trips seeded, thank you computer Jesus"'


stations = delete_columns("./db/csv/station.csv", [:lat, :long])
trips = CSV.foreach "./db/csv/trip.csv", headers: true, header_converters: :symbol

  stations.each do |row|
    row = row.to_h
    row[:installation_date] = Date.strptime(row[:installation_date], '%m/%d/%Y')
    Station.create!(row)
  end
  
start_time = Time.now
  count = 0
  trips.each do |row|
    row = row.to_h
    row[:start_station_id] = Station.id_by_name(row.delete(:start_station_name))
    row[:end_station_id] = Station.id_by_name(row.delete(:end_station_name))
    row[:zip_code] = clean_zipcode(row[:zip_code])
    row[:start_date] = Date.strptime(row[:start_date], "%m/%d/%Y")
    row[:end_date] = Date.strptime(row[:end_date], "%m/%d/%Y")
    Trip.create!(row)
    count += 1
    puts count
  end
puts (Time.now - start_time)