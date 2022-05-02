require "json"
require "http/client"
require "../models"

module Repository
  class Weathernews
    def initialize(@point : Models::Point)
      @url = "https://weathernews.jp/onebox/#{@point.lat}/#{@point.lng}/"
    end

    def get_rainy_percents
      res = HTTP::Client.get @url

      base = res.body
        .split("day2Table day2__wind")[1]
        .split("<div class=\"day2Table__item\">")

      {
        "am": pick_up_percent(base[1]),
        "pm": pick_up_percent(base[2]),
      }
    end

    private def pick_up_percent(base : String): Int
      base
        .split("class=\"text wTable__item\">")[1]
        .split("<span")[0]
        .to_i { 0 }
    end
  end
end
