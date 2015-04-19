class CreateDailyReadings < ActiveRecord::Migration
  def change
    create_table :daily_readings do |t|
      t.date :date
      t.references :location, index: true

      t.timestamps null: false
    end
    add_foreign_key :daily_readings, :locations
  end
end
