class FixingUp < ActiveRecord::Migration
  def change
    drop_table :weather_readings
  end
end
