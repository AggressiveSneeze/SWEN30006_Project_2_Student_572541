#
# config/initializers/scheduler.rb

require 'rufus-scheduler'
require 'reader_driver'
require 'bom_reader'
require 'forecast_io_reader'


# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton


#bom_scheduling

s.in '1s' do

  bom_reader=BomReader.new
  ReaderDriver.read(bom_reader)
  forecast_reader=ForecastIOReader.new
  ReaderDriver.read(forecast_reader)

end


s.every '10m' do

  bom_reader=BomReader.new
  ReaderDriver.read(bom_reader)

end

#forecast scheduling
s.every '32m' do
  forecast_reader=ForecastIOReader.new
  ReaderDriver.read(forecast_reader)
end