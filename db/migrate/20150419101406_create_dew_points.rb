class CreateDewPoints < ActiveRecord::Migration
  def change
    create_table :dew_points do |t|
      t.float :dew_point
      t.references :weather_reading, index: true

      t.timestamps null: false
    end
    add_foreign_key :dew_points, :weather_readings
  end
end
