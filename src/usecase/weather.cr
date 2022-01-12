require "../repository/weathernews"
require "../models"

module Usecase
  class Weather
    @alert_threshold = 45
    @warning_threshold = 65
    @check_times = {
      "12": "朝方",
      "18": "午後",
      "24": "夜間",
    }

    def initialize
    end

    def check_need_umbrella(point : Models::Point)
      wn = Repository::Weathernews.new point
      rainy_percents = wn.get_rainy_percents

      {
        "alert":   map_need_time(rainy_percents, @alert_threshold),
        "warning": map_need_time(rainy_percents, @warning_threshold),
      }
    end

    private def map_need_time(rainy_percents, threshold : Int32)
      @check_times
        .map do |key, _|
          key
        end
        .select do |time|
          rainy_percents[time] > threshold
        end
        .map do |item|
          @check_times[item]
        end
    end
  end
end
