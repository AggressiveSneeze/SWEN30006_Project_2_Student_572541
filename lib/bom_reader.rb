require 'nokogiri'
require 'open-uri'
require 'time'
require 'chronic'

#Implements the ability to read weather data from bom.gov.au using the nokogiri HTML parsing gem.
class BomReader
  @@URL = "http://www.bom.gov.au/vic/observations/melbourne.shtml"
  @@SOURCE_STRING = 'BoM - Bureau of Meteorology'
  @@MIN_LENGTH = 100
  @@nine_am = '09:00am'

  #constructor
  def initialize
  end

  #Performs a weather reading for the daily_reading argument.
  def weather_reading(daily_reading)

    # Open the HTML link with Nokogiri
    doc = Nokogiri::HTML(open(@@URL))
    #Now to find where all the info is stored for each location, and store it in a hash so we know
    #where a particular city's weather info is stored.
    locations=doc.css('table#tMELBOURNE .rowleftcolumn, table#tMELBOURNE .contrast')
    loc_hash=Hash.new
    counter=0
    locations.each {|x|
      #easy way to check whether the entry is the set of weather data for a location or whether it's
      #a non-necessary element for our purposes.
      if x.text.length > @@MIN_LENGTH
        name=x.css("th").text
        loc_hash[name]=counter
      end
      counter+=1
    }
    loc=daily_reading.location

    #grab the weather data for the location we're reading for.
    weather_data=locations[loc_hash[loc.name]].css("td")


    #Where particular information is stored for a given weather reading.

    #weather_data[0]=datetime,[1]=temp,[2]=apptemp,[3]=dewpoint,[4]=relhum,[5]=delta_t,[6]=wind_dir
    #[7]=wind_spd_kph, [8]=wind_gust_kph, [9] = wind_spd_knts, [10] = wind_gust_knts, [11] = pressure,
    #[12]=rainsince9am, [13]=lowtemp, [14]=hightemp, [15]= highwind direction,[16]=highwind_gust_kph,
    # [17]=highwind_gust_knts

    #Grab the time and get rid of the date, (just a result of how bom lists the date/time)
    time=weather_data[0].text.split('/')[1]

    #create a new weather reading row
    weather_reading=daily_reading.weather_readings.create({source:@@SOURCE_STRING,time:time})


    #Create and populate all the required 'complementary' rows for the new weather reading.
    #Create a new dewpoint reading.
    DewPoint.create({dew_point:weather_data[3].text,weather_reading_id: weather_reading.id})

    #Obtain and store the temperature reading.
    temp=weather_data[1].text
    app_temp=weather_data[2].text
    Temperature.create({temperature:temp,apparent_temperature:app_temp,weather_reading_id: weather_reading.id})
    #Obtain and store the wind reading.
    wind_direction=Wind.orientation_to_bearing(weather_data[6].text)
    wind_speed=weather_data[7].text
    Wind.create({direction:wind_direction,speed:wind_speed,weather_reading_id: weather_reading.id})

    #obtain and store the rain reading after converting it to mm/hour
    rain=weather_data[12].text
    hours_since_9am=((Chronic.parse(time)-Chronic.parse(@@nine_am))/1.hour)
    #Avoids dividing by 0.
    if hours_since_9am==0
      amount_rain=0
    else
      amount_rain=rain.to_f/hours_since_9am
    end

    Rainfall.create({amount:amount_rain, weather_reading_id: weather_reading.id})

  end


end