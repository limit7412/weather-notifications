require "json"
require "http/client"
require "../models"

module Repository
  class Weathernews
    def initialize(@point : Models::Point)
      @url = "http://weathernews.jp/onebox/#{@point.lat}/#{@point.lng}/"
    end

    def get_rainy_percents
      res = HTTP::Client.get "#{@url}type=day"

      base = res.body.split("weather-2day__rainy")[1].split("<td>")

      return {
        "6":  pick_up_percent(base[1]),
        "12": pick_up_percent(base[2]),
        "18": pick_up_percent(base[3]),
        "24": pick_up_percent(base[4]),
      }
    end

    private def pick_up_percent(base : String)
      base.split("</td>")[0].split(" ")[0].to_i { 0 }
    end
  end
end
