class CreateRainfalls < ActiveRecord::Migration
  def change
    create_table :rainfalls do |t|
      t.float :amount
      t.references :weather_reading, index: true

      t.timestamps null: false
    end
    add_foreign_key :rainfalls, :weather_readings
  end
end
