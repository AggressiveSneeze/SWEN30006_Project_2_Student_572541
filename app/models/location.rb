class Location < ActiveRecord::Base
  has_many :daily_readings

  def today
    today=Time.now.strftime('%Y-%m-%d')

    if((!self.daily_readings.last) || (self.daily_readings.last.date.to_s!=today))
      return NIL
    else
      return self.daily_readings.last
    end
  end

  def today?
    today=Time.now.strftime('%Y-%m-%d')
    #debug messages
    # puts "the type in the last one is: #{self.daily_readings.last.date.to_s}"
    # puts "today's date is #{today}"
    # puts "condition 1: #{self.daily_readings.last}, condition 2: #{self.daily_readings.last.date.to_s==today}"
    # puts "overall: #{self.daily_readings.last && self.daily_readings.last.date.to_s==today}"
    return (self.daily_readings.last && self.daily_readings.last.date.to_s==today)
  end




end





