class Wind < ActiveRecord::Base
  belongs_to :weather_reading

  def self.orientation_to_bearing(orientation)
    h = {n: 0, ne: 45, e: 90, se: 135, s: 180, sw: 225, w: 270, nw: 315,
         nne: 11.25, ene: 67.50, ese: 112.5, sse: 151.88, ssw: 202.5, wsw: 247.50, wnw: 292.50, nnw: 337.50}
    h[orientation.to_s.downcase.to_sym]
  end

end
