require "json"
require "http/client"
require "../model"

class Weathernews
  def initialize(@point : Point)
    @url = "http://weathernews.jp/onebox/#{@point.lat}/#{@point.lng}/type=day"
  end

  def get_rainy_percents
    res = HTTP::Client.get @url

    base = res.body.split("weather-2day__rainy")[1].split("<td>")

    return {
      "6":  base[1].split("</td>")[0].split(" ")[0],
      "12": base[2].split("</td>")[0].split(" ")[0],
      "18": base[3].split("</td>")[0].split(" ")[0],
      "24": base[4].split("</td>")[0].split(" ")[0],
    }
  end
end
