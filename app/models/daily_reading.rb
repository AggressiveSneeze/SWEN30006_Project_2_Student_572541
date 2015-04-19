class DailyReading < ActiveRecord::Base
  belongs_to :location
  has_many :weather_readings

end
