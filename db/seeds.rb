require './app/models/station.rb'
require './app/models/trip.rb'
require './app/models/condition.rb'
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

def pick_a_stupid_zipcode(zip_code)
  result = false
  if zip_code == "95113"
    result = true
  end
end

def clean_conditions(measurement)
  if measurement.nil?
    measurement = 0.0
  end
  measurement
end

def seed_by_date(date)
  date_array = (date).split("/")
  date = "#{date_array[1]}/#{date_array[0]}/#{date_array[2]}"
end


Station.destroy_all
# system 'Say "Good morning Joan, I love you, I will never leave you, destroy stations complete"'
Trip.destroy_all
# system 'Say "Trips seeded, thank you computer Jesus"'
Condition.destroy_all
# system 'Say "All bunnies must die Die Bunnies die bunnies die die die die all bunnies"'

conditions = CSV.foreach "./db/csv/weather.csv", headers: true, header_converters: :symbol
stations = delete_columns("./db/csv/station.csv", [:lat, :long])
trips = CSV.foreach "./db/csv/trip.csv", headers: true, header_converters: :symbol

conditions = CSV.foreach "./db/csv/weather.csv", headers: true, header_converters: :symbol


puts "finished with csvs"

  stations.each do |row|
    row = row.to_h
    row[:installation_date] = Date.strptime(row[:installation_date], '%m/%d/%Y')
    Station.create!(row)
    puts "finished station"
  end

  conditions.each do |row|
    row=row.to_h
    clean_row = {}
    clean_row[:zip_code] = clean_zipcode(row[:zip_code])
    clean_row[:max_temperature] = clean_conditions(row[:max_temperature_f])
    clean_row[:mean_temperature] = clean_conditions(row[:mean_temperature_f])
    clean_row[:min_temperature] = clean_conditions(row[:min_temperature_f])
    clean_row[:mean_humidity] = clean_conditions(row[:mean_humidity])
    clean_row[:mean_visibility] = clean_conditions(row[:mean_visibility_miles])
    clean_row[:mean_wind_speed] = clean_conditions(row[:mean_wind_speed_mph])
    clean_row[:precipitation] = clean_conditions(row[:precipitation_inches])
    row[:weather_date] = row[:date]
    clean_row[:weather_date] = seed_by_date(row[:weather_date])
    puts "finished rows"
    Condition.create!(clean_row) if pick_a_stupid_zipcode(row[:zip_code])
  end
  puts "done conditions"
start_time = Time.now

  count = 0

  trips.each do |row|
    row = row.to_h
    row[:start_station_id] = Station.id_by_name(row.delete(:start_station_name))
    row[:end_station_id] = Station.id_by_name(row.delete(:end_station_name))
    row[:zip_code] = clean_zipcode(row[:zip_code])
    row[:start_date] = Date.strptime(row[:start_date], "%m/%d/%Y")
    row[:end_date] = Date.strptime(row[:end_date], "%m/%d/%Y")
    row[:condition_id] = Condition.id_by_date(row[:start_date])
    Trip.create!(row)
    count += 1
    puts count
  end


  

puts (Time.now - start_time)
