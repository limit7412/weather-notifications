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
      need_umbrella = @weather.check_need_umbrella point

      break if need_umbrella[:alert].size == 0

      text = "#{place}では#{need_umbrella[:alert].join("、")}に雨が降る可能性があります。折りたたみ傘が必要かもしれません。"

      if need_umbrella[:warning].size != 0
        text += "特に#{need_umbrella[:warning].join("、")}は降水確率が高いので注意してください。"
      end

      text
    end
  end
end
