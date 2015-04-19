class Temperature < ActiveRecord::Base
  belongs_to :weather_reading
end
