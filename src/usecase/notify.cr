require "../repository/geocoding"
require "./weather"
require "../model"

class Notify
  def initialize
    @weather = Weather.new
  end

  def check_weather
    ENV["CHECK_PLACE"].split(",").each do |place|
      point = Geocoding.get place
      @weather.check point

      # api負荷対策
      sleep 15
    end
  end
end
