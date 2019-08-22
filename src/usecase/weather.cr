require "../repository/weathernews"
require "../model"

class Weather
  def initialize
  end

  def check_rainy_percents(point : Point)
    wn = Weathernews.new point
    rainy_percents = wn.check
    puts rainy_percents["24"]
  end
end
