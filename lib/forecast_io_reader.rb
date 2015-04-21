require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'forecast_io_reader'
#from https://github.com/darkskyapp/forecast-ruby


class ForecastIOReader
  #Where should this stuff go?
  @@API_KEY = 'cabbc3ce98635516063fe2407c9d8be9'
  @@SOURCE_STRING = 'Forecast.io'
  ForecastIO.api_key="#{@@API_KEY}"
  ForecastIO.default_params = {:units=>'ca', :exclude => 'minutely,hourly,daily,alerts,flags'}

  def initialize
  end

  def weather_reading(daily_reading)
    long=daily_reading.location.longitude
    lat=daily_reading.location.latitude
    forecast=forecast_json(lat,long)

    weather_reading=daily_reading.readings.create({source:@@SOURCE_STRING,time:forecast.currently.time})

    weather_reading.dewpoint.create({dew_point:forecast.currently.dewPoint})
    temp=forecast.currently.temperature
    app_temp=forecast.currently.apparentTemperature
    weather_reading.temperature.create({temperature:temp,apparent_temperature:app_temp})
    wind_direction=forecast.currently.windBearing.to_s
    wind_speed=forecast.currently.windSpeed
    weather_reading.wind.create({direction:wind_direction,speed:wind_speed})

    #should precipIntensity be okay?
    rain=forecast.currently.precipIntensity
    weather_reading.rain.create({amount:rain})


    #How to store these things? Make new rows in the db straight away?
  end

  def forecast_json(latitude,longitude)
    return ForecastIO.forecast(latitude,longitude)
  end
end

# weather_reading(DailyReading.new)
puts "hello"