class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.float :temperature
      t.float :apparent_temperature
      t.references :weather_reading, index: true

      t.timestamps null: false
    end
    add_foreign_key :temperatures, :weather_readings
  end
end
