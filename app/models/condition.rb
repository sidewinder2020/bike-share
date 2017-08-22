
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

end
