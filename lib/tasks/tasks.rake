
require_relative('../forecast_io_reader')
require_relative('../bom_reader')
require_relative('../reader_driver')


#Rake tasks to individually run a weather reading from a particular source.
#Run via "rake forecast_io or rake bom"" in rails console
task forecast_io: :environment do
    forecast_io=ForecastIOReader.new
    ReaderDriver.read(forecast_io)
end

task bom: :environment do
  bom_reader=BomReader.new
  ReaderDriver.read(bom_reader)
end
