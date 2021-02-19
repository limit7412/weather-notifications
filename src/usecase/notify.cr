require "../repository/geocoding"
require "../repository/discord"
require "./weather"

module Usecase
  class Notify
    def initialize
      @weather = Weather.new
      @geocoding = Repository::Geocoding.new
      @discord = Repository::Discord.new ENV["WEBHOOK_URL"]
    end

    def check_weather
      need_umbrella = ENV["CHECK_PLACE"]
        .split(",")
        .map_with_index do |place, index|
          # api負荷対策
          sleep 15 if index != 0

          point = @geocoding.get place
          res = @weather.check_need_umbrella point

          {
            place:         place,
            need_umbrella: res,
          }
        end
        .select do |item|
          item[:need_umbrella][:alert].size != 0
        end

      return if need_umbrella.size == 0

      alert = need_umbrella
        .map do |item|
          "#{item[:place]}では#{item[:need_umbrella][:alert].join("、")}"
        end
      text = "今日は#{alert.join("、")}に雨が降る可能性があります。折りたたみ傘を持ち歩いたほうがいいかもしれません。"

      warning = need_umbrella
        .map do |item|
          next if item[:need_umbrella][:warning].size == 0
          "#{item[:place]}では#{item[:need_umbrella][:warning].join("、")}"
        end
        .select do |item|
          item != nil
        end
      text += "特に#{warning.join("、")}の降水確率が高いので注意してください。" if warning.size != 0

      @discord.send_post({
        content: "@everyone\n" + text + "\n詳しい情報はこちらで確認してくださいね！\nhttps://weathernews.jp",
      })
    end
  end
end
