class CreateWeatherReadings < ActiveRecord::Migration
  def change
    create_table :weather_readings do |t|
      t.string :source
      t.text :time
      t.references :daily_reading, index: true

      t.timestamps null: false
    end
    add_foreign_key :weather_readings, :daily_readings
  end
end
