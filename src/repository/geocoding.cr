require "http/client"
require "../model"

module Geocoding
  extend self

  def get(place : String) : Point
    res = HTTP::Client.get "https://www.geocoding.jp/api/?q=#{place}"

    lat = res.body.split("<lat>")[1].split("</lat>")[0]
    lng = res.body.split("<lng>")[1].split("</lng>")[0]

    Point.new lat, lng
  end
end
