class Picture
  def initialize(link, o_lat, o_lon, lat, lon)
    @url = link
    @distance = find_distance(o_lat.to_f, o_lon.to_f, lat.to_f, lon.to_f)
  end

  private

  def find_distance(o_lat, o_lon, lat, lon)
    lat_diff = o_lat >= lat ? (o_lat - lat).abs.to_i : (lat - o_lat).abs.to_i
    lon_diff = o_lon >= lon ? (o_lon - lon).abs.to_i : (lon - o_lon).abs.to_i
    if lon_diff == 0 && lat_diff == 0
      0
    elsif lon_diff == 0
      lat_diff
    elsif lat_diff == 0
      lon_diff
    else
      Math.hypot(lat_diff, lon_diff)
    end
  end
end