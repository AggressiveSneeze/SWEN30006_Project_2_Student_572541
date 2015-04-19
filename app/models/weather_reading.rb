class WeatherReading < ActiveRecord::Base
  belongs_to :daily_reading
  has_one :temperature
  has_one :dew_point
  has_one :wind
  has_one :rainfall
end
