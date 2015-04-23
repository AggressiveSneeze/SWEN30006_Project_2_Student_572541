#
# config/initializers/scheduler.rb

#Implements the required functionality of automatically scraping weather data at pre-determined time intervals.


require 'rufus-scheduler'
require 'reader_driver'
require 'bom_reader'
require 'forecast_io_reader'


# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton



#Kicks off the readings from time=0.
s.in '1s' do

  bom_reader=BomReader.new
  ReaderDriver.read(bom_reader)
  forecast_reader=ForecastIOReader.new
  ReaderDriver.read(forecast_reader)

end

#bom_scheduling
s.every '10m' do

  bom_reader=BomReader.new
  ReaderDriver.read(bom_reader)

end

#forecast_io scheduling
s.every '32m' do
  forecast_reader=ForecastIOReader.new
  ReaderDriver.read(forecast_reader)
end