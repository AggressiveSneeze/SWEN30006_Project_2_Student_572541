require 'nokogiri'
require 'open-uri'
require 'JSON'


class ForecastIOReader
  #Where should this stuff go?
  @@API_KEY = 'cabbc3ce98635516063fe2407c9d8be9'
  @@BASE_URL = 'https://api.forecast.io/forecast'
  @@SOURCE_STRING = 'ForecastIO'

  def initialize
  end

  def weather_reading(daily_reading)
    loc=Location.find(daily_reading.location_id)
    long=loc.longitude
    lat=loc.latitude
    forecast = JSON.parse(open("#{@@BASE_URL}/#{@@API_KEY}/#{lat},#{long}?units=ca&exclude='minutely,hourly,daily,alerts,flags'").read)


    weather_reading=daily_reading.weather_readings.create({source:@@SOURCE_STRING,time:forecast['currently']['time']})
    DewPoint.create({dew_point:forecast['currently']['dewPoint'],weather_reading_id: weather_reading.id})
    #weather_reading.dew_point.create({dew_point:forecast['currently']['dewPoint']})
    temp=forecast['currently']['temperature']
    app_temp=forecast['currently']['apparentTemperature']
    Temperature.create({temperature:temp,apparent_temperature:app_temp,weather_reading_id: weather_reading.id})
    wind_direction=forecast['currently']['windBearing'].to_s
    wind_speed=forecast['currently']['windSpeed']
    #weather_reading.wind.create({direction:wind_direction,speed:wind_speed})
    Wind.create({direction:wind_direction,speed:wind_speed,weather_reading_id: weather_reading.id})

    #should precipIntensity be okay?
    rain=forecast['currently']['precipIntensity']
    #weather_reading.rain.create({amount:rain})
    Rainfall.create({amount:rain, weather_reading_id: weather_reading.id})

    #How to store these things? Make new rows in the db straight away?
  end

  def potato
    puts 'cheese'
  end
end

# weather_reading(DailyReading.new)
puts "hello"