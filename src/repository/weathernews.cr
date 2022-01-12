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

      base = res.body
        .split("day2Table day2__wind")[1]
        .split("<div class=\"day2Table__item\">")

      {
        "6":  pick_up_percent(base[1]),
        "12": pick_up_percent(base[2]),
        "18": pick_up_percent(base[3]),
        "24": pick_up_percent(base[4]),
      }
    end

    private def pick_up_percent(base : String): Int
      base
        .split("<p class=\"text\">")[1]
        .split("<span")[0]
        .delete("\"")
        .to_i { 0 }
    end
  end
end
