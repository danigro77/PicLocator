class Picture

  attr_reader :distance

  def initialize(link, distance)
    @url = link
    @distance = distance
  end

end