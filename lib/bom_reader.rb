require 'nokogiri'
require 'open-uri'

class BomReader
  @@URL = "http://www.bom.gov.au/vic/observations/melbourne.shtml"
  @@SOURCE_STRING = 'BoM - Bureau of Meteorology'

  def initialize
  end

  def weather_reading(daily_reading)
    # loc=Location.find(daily_reading.location_id)
    # long=loc.longitude
    # lat=loc.latitude
    # forecast = JSON.parse(open("#{@@BASE_URL}/#{@@API_KEY}/#{lat},#{long}?units=ca&exclude='minutely,hourly,daily,alerts,flags'").read)
    #
    #
    # weather_reading=daily_reading.weather_readings.create({source:@@SOURCE_STRING,time:forecast['currently']['time']})
    # DewPoint.create({dew_point:forecast['currently']['dewPoint'],weather_reading_id: weather_reading.id})
    # #weather_reading.dew_point.create({dew_point:forecast['currently']['dewPoint']})
    # temp=forecast['currently']['temperature']
    # app_temp=forecast['currently']['apparentTemperature']
    # Temperature.create({temperature:temp,apparent_temperature:app_temp,weather_reading_id: weather_reading.id})
    # wind_direction=forecast['currently']['windBearing'].to_s
    # wind_speed=forecast['currently']['windSpeed']
    # #weather_reading.wind.create({direction:wind_direction,speed:wind_speed})
    # Wind.create({direction:wind_direction,speed:wind_speed,weather_reading_id: weather_reading.id})
    #
    # #should precipIntensity be okay?
    # rain=forecast['currently']['precipIntensity']
    # #weather_reading.rain.create({amount:rain})
    # Rainfall.create({amount:rain, weather_reading_id: weather_reading.id})
    #
    # #How to store these things? Make new rows in the db straight away?

    # Define the URL we are opening


    # Open the HTML link with Nokogiri
    doc = Nokogiri::HTML(open(@@URL))
    locations=doc.css("table#tMELBOURNE .rowleftcolumn, table#tMELBOURNE .contrast")
    loc_hash=Hash.new
    counter=0
    locations.each {|x|
      #easy way to check whether the entry is the set of weather data for a location
      if x.text.length > 100
        name=x.css("th").text
        loc_hash[name]=counter
      end
      counter+=1
    }
    loc=Location.find(daily_reading.location_id)
    weather_data=locations[loc_hash[loc.name]].css("td")


    #weather_data[0]=datetime,[1]=temp,[2]=apptemp,[3]=dewpoint,[4]=relhum,[5]=delta_t,[6]=wind_dir
    #[7]=wind_spd_kph, [8]=wind_gust_kph, [9] = wind_spd_knts, [10] = wind_gust_knts, [11] = pressure,
    #[12]=rainsince9am, [13]=lowtemp, [14]=hightemp, [15]= highwind direction,[16]=highwind_gust_kph,[17]=highwind_gust_knts


    time=weather_data[0].text.split('/')[1]

    weather_reading=daily_reading.weather_readings.create({source:@@SOURCE_STRING,time:time})

    DewPoint.create({dew_point:weather_data[3].text,weather_reading_id: weather_reading.id})
    #weather_reading.dew_point.create({dew_point:forecast['currently']['dewPoint']})
    temp=weather_data[1].text
    app_temp=weather_data[2].text
    Temperature.create({temperature:temp,apparent_temperature:app_temp,weather_reading_id: weather_reading.id})
    wind_direction=weather_data[6].text
    wind_speed=weather_data[7].text
    #weather_reading.wind.create({direction:wind_direction,speed:wind_speed})
    Wind.create({direction:wind_direction,speed:wind_speed,weather_reading_id: weather_reading.id})

    #should rainsince9am be okay?
    rain=weather_data[12].text
    #weather_reading.rain.create({amount:rain})
    Rainfall.create({amount:rain, weather_reading_id: weather_reading.id})

  end

  def potato
    puts 'cheese'
  end


end