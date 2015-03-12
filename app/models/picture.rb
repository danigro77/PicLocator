class Picture
  attr_reader :distance,:url

  def initialize(link, distance)
    @url = link
    @distance = distance
  end

  def self.get_picture(image, o_lat, o_lon, dis=0)
    url = image['images']['standard_resolution']['url']
    lat, lon = image['location']['latitude'], image['location']['longitude']
    distance = find_distance([o_lat, o_lon], [lat, lon])/1000
    distance > dis ? nil : Picture.new(url, distance)
  end

  def self.find_distance(loc1, loc2) # http://stackoverflow.com/questions/12966638/how-to-calculate-the-distance-between-two-gps-coordinates-without-using-google-m
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c # Delta in meters
  end

end