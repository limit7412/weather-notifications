require "../repository/weathernews"
require "../model"

class Weather
  @alert_threshold = 45
  @warning_threshold = 65
  @check_times = {
    "12": "朝",
    "18": "昼",
    "24": "夜",
  }

  def initialize
  end

  def check_need_umbrella(point : Point)
    wn = Weathernews.new point
    rainy_percents = wn.get_rainy_percents

    return {
      "alert":   map_need_time(rainy_percents, @alert_threshold),
      "warning": map_need_time(rainy_percents, @warning_threshold),
    }
  end

  private def map_need_time(rainy_percents, threshold : Int32)
    @check_times
      .map { |key, val| key }
      .select { |time|
        rainy_percents[time] > threshold
      }
      .map { |item|
        @check_times[item]
      }
  end
end
