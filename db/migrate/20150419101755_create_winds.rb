class CreateWinds < ActiveRecord::Migration
  def change
    create_table :winds do |t|
      t.string :direction, :default=> 'NULL'
      t.float :speed, :default=> '0'
      t.references :weather_reading, index: true

      t.timestamps null: false
    end
    add_foreign_key :winds, :weather_readings
  end
end
