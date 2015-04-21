namespace :reading do
  task read_weather: :development do

    forecast_io=ForecastIoReader.new

    ReaderDriver.read(forecast_io)

  end
end