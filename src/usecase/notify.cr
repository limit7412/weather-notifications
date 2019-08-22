require "./weather"

class Notify
  def initialize
    @weather = Weather.new
  end

  def check_weather
    @weather.check
  end
end
