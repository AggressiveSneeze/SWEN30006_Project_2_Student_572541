module ReaderDriver

  def read(source_reader)
    #generate a string with today's date
    time=Time.now
    today=time.day.to_s+'/'+time.month.to_s+'/'+time.year.to_s
    #iterate over every location

    Location.find_each do |location|
      if location.daily_readings.last.date!=today
        daily=location.daily_readings.create({date:today})
      else
        daily=location.daily_readings.last
      end
      source_reader.weather_reading(daily)


    end
  end

end

