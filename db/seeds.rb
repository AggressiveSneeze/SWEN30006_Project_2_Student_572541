# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'
#require 'JSON'
#require 'forecast_io'
#from https://github.com/darkskyapp/forecast-ruby
#http://stackoverflow.com/questions/8162444/ruby-regex-extracting-words
# Define the URL
BASE_URL = 'http://www.bom.gov.au'

# Define the URL we are opening
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'

# Open the HTML link with Nokogiri
doc = Nokogiri::HTML(open(URL))

#obtain the links to the station pages
locations= doc.css("table#tMELBOURNE th a")

locations.each {|city|
  temp_link=city['href']
  #puts locations[city]['href'].class
  temp_url = BASE_URL+temp_link
  temp_doc=Nokogiri::HTML(open(temp_url))
  #an array of all the td elements for that station
  #[[3] is lat, [4] is long
  station_details=temp_doc.css('.stationdetails td')
  #name
  station_name=city.text
  #latitude
  lat=station_details[3].text.match(/\d+[,.]\d+/)[0].to_f
  #long:
  long=station_details[4].text.match(/\d+[,.]\d+/)[0].to_f
  Location.create({longitude:long, latitude:lat, name:station_name})
}