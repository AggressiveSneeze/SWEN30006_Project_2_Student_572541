module ReaderDriver

  def self.read(source_reader)
    #generate a string with today's date
    today=Time.now.strftime('%Y-%m-%d')
    #iterate over every location

    Location.find_each do |location|
      if location.today?
        #puts 'carrot'
        daily=location.today
      else
        #puts 'celery'
        daily=location.daily_readings.create({date:today})
      end
      source_reader.weather_reading(daily)

    end
  end

  def self.potato
    puts 'hee'
  end

end

