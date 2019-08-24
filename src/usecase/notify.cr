require "../repository/geocoding"
require "./weather"
require "../model"

class Notify
  def initialize
    @weather = Weather.new
  end

  def check_weather
    ENV["CHECK_PLACE"].split(",").map_with_index do |place, index|
      # api負荷対策
      sleep 15 if index != 0

      point = Geocoding.get place
      @weather.check_need_umbrella point
    end
  end
end
