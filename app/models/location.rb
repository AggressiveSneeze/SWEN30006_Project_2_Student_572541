class Location < ActiveRecord::Base
  has_many :daily_readings
end
