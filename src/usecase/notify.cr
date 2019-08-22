require "./weather"

class NotifyUsecase
  def initialize
    @weather = WeatherUsecase.new
  end

  def check_weather
    @weather.check
  end
end
