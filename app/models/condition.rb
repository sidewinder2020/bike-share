require 'will_paginate'
require 'will_paginate/active_record'
require './app/models/trip'
class Condition < ActiveRecord::Base
	validates :weather_date,     presence: true
	validates :max_temperature,  presence: true
	validates :mean_temperature, presence: true
	validates :min_temperature,  presence: true
	validates :mean_humidity,    presence: true
	validates :mean_visibility,  presence: true
	validates :mean_wind_speed,  presence: true
	validates :precipitation,    presence: true
	validates :zip_code,         presence: true


	has_many :trips
	has_many :trips, class_name: "Trip", foreign_key: "condition_id"

	def self.id_by_date(date)
		find_by(weather_date: date).id
	end

	def self.breakout(temp_range)
		range = trip_temps(temp_range)
		answers = Hash.new(0)
		answers[:min] = (range.values.last || 0)
		answers[:max] = (range.values.first || 0)
		if range.values.count != 0
			answers[:avg] = range.values.sum / range.values.count
		else
			answers[:avg] = 0
		end
		answers
	end

	def self.trip_temps(temp_range)
		select("condition.*, sum(trip.condition_id) AS total_trips")
			.joins(:trips).where(max_temperature: (temp_range...(temp_range + 10)))
			.group(:conditions).order("count_id DESC").count(:id)
	end

	def self.breakout_temps
		counter = 40.0
		temp = Hash.new(0)
		until counter == 100
			temp.merge!(counter=>breakout(counter))
			counter += 10
		end
		temp
	end

	def self.breakout_inches(precip_range)
		range = precip_trips(precip_range)
		answers = Hash.new(0)
		answers[:min] = (range.values.last || 0)
		answers[:max] = (range.values.first || 0)
		if range.values.count != 0
			answers[:avg] = range.values.sum / range.values.count
		else
			answers[:avg] = 0
		end
		answers
	end

	def self.breakout_precip
		counter = 0.0
		temp = Hash.new(0)
		until counter == 3.5
			temp.merge!(counter=>breakout_inches(counter))
			counter += 0.5
		end
		temp
	end

	def self.precip_trips(range)
		select("condition.*, sum(trip.condition_id) AS total_trips")
			.joins(:trips).where(precipitation: (range...(range + 0.5)))
			.group(:conditions).order("count_id DESC").count(:id)
	end

	def self.breakout_speed
		counter = 0.0
		speed = Hash.new(0)
		until counter == 16.0
			speed.merge!(counter=>breakout_mph(counter))
			counter += 4.0
		end
		speed
	end

	def self.wind_speed_trips(range)
		select("condition.*, sum(trip.condition_id) AS total_trips")
			.joins(:trips).where(mean_wind_speed: (range...(range + 4.0)))
			.group(:conditions).order("count_id DESC").count(:id)
	end

	def self.breakout_mph(speed_range)
		range = wind_speed_trips(speed_range)
		answers = Hash.new(0)
		answers[:min] = (range.values.last || 0)
		answers[:max] = (range.values.first || 0)
		if range.values.count != 0
			answers[:avg] = range.values.sum / range.values.count
		else
			answers[:avg] = 0
		end
		answers
	end

	def self.breakout_view
		counter = 0.0
		speed = Hash.new
		until counter >= 10.0
			speed.merge!(counter=>breakout_sight(counter))
			counter += 4.0
		end
		speed
	end

	def self.sight_dist_trips(range)
		select("condition.*, sum(trip.condition_id) AS total_trips")
			.joins(:trips).where(mean_visibility: (range...(range + 4.0)))
			.group(:conditions).order("count_id DESC").count(:id)
	end

	def self.breakout_sight(sight_range)
		range = sight_dist_trips(sight_range)
		answers = Hash.new(0)
		answers[:min] = (range.values.last || 0)
		answers[:max] = (range.values.first || 0)
		if range.values.count != 0
			answers[:avg] = range.values.sum / range.values.count
		else
			answers[:avg] = 0
		end
		answers
	end

	def self.best_weather_trip_day
		find( Trip.joins(:condition).group(:condition_id)
			.order("count_id DESC").count(:id).keys.first)
	end

	def self.worst_weather_trip_day
		find( Trip.joins(:condition).group(:condition_id)
			.order("count_id DESC").count(:id).keys.last)
	end

end
