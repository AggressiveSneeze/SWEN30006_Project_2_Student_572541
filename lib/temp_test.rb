#Just a rudimentary test to run the scraping outside of the rails 'scheduled scraping' environment

#http://stackoverflow.com/questions/10313181/pass-ruby-script-file-to-rails-console

#for forecastio
require 'reader_driver'
require 'forecast_io_reader'
forecast=ForecastIOReader.new
ReaderDriver.read(forecast)

# #for bom
# require 'reader_driver'
# require 'bom_reader'
# bom_reader=BomReader.new
# ReaderDriver.read(bom_reader)
