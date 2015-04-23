require 'nokogiri'
require 'open-uri'
require 'JSON'
require 'time'



#Implements the ability to read weather data from forecast.io by parsing the JSON hash.
class ForecastIOReader


  @@API_KEY = 'cabbc3ce98635516063fe2407c9d8be9'
  @@BASE_URL = 'https://api.forecast.io/forecast'
  @@SOURCE_STRING = 'ForecastIO'

  #Constructor
  def initialize
  end

  #Performs a weather reading for the daily_reading argument.
  def weather_reading(daily_reading)

    loc=daily_reading.location
    long=loc.longitude
    lat=loc.latitude
    #Get the hash with all the forecast data.
    forecast = JSON.parse(open("#{@@BASE_URL}/#{@@API_KEY}/#{lat},#{long}?units=ca&exclude='minutely,hourly,daily,alerts,flags'").read)

    #convert time to am/pm:
    time=Time.at(forecast['currently']['time'])
    time=time.strftime('%I:%M%p').downcase

    #Create new weather reading.
    weather_reading=daily_reading.weather_readings.create({source:@@SOURCE_STRING,time:time})

    #Create and populate all the required 'complementary' rows for the new weather reading.

    #Create new dew point.
    DewPoint.create({dew_point:forecast['currently']['dewPoint'],weather_reading_id: weather_reading.id})
    #Obtain and store temperature info.
    temp=forecast['currently']['temperature']
    app_temp=forecast['currently']['apparentTemperature']
    Temperature.create({temperature:temp,apparent_temperature:app_temp,weather_reading_id: weather_reading.id})
    #Obtain and store wind info.
    wind_direction=forecast['currently']['windBearing'].to_s
    wind_speed=forecast['currently']['windSpeed']
    Wind.create({direction:wind_direction,speed:wind_speed,weather_reading_id: weather_reading.id})

    #should precipIntensity be okay?
    rain=forecast['currently']['precipIntensity']
    #weather_reading.rain.create({amount:rain})
    Rainfall.create({amount:rain, weather_reading_id: weather_reading.id})
  end

end
