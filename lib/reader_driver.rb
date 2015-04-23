#Provides a method to read in weather data from a particular source (using an instance of that source's reader class)
#Assumes source_reader.class implements a #weather_reading(daily_reading) method.

module ReaderDriver

  #Drives the source_reader to perform a weather reading.

  def self.read(source_reader)
    #generate a string with today's date
    today=Time.now.strftime('%Y-%m-%d')
    #iterate over every location

    Location.find_each do |location|
      if location.today?
        daily=location.today
      else
        daily=location.daily_readings.create({date:today})
      end
      source_reader.weather_reading(daily)

    end
  end

end

