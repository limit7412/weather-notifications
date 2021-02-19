require "http/client"
require "../models"

module Repository
  class Geocoding
    def initialize
    end

    def get(place : String) : Models::Point
      res = HTTP::Client.get "https://www.geocoding.jp/api/?q=#{place}"

      lat = res.body.split("<lat>")[1].split("</lat>")[0]
      lng = res.body.split("<lng>")[1].split("</lng>")[0]

      Models::Point.new lat, lng
    end
  end
end
