require "json"
require "../repository/slack"

module Usecase
  class Alert
    def initialize(@error : Exception)
      @slack = Repository::Slack.new ENV["FAILD_WEBHOOK_URL"]
    end

    def send
      post = {
        fallback: ENV["FAILD_FALLBACK"],
        pretext:  "<@#{ENV["SLACK_ID"]}> #{ENV["FAILD_FALLBACK"]}",
        title:    @error.message,
        text:     @error.backtrace.join("\n"),
        color:    "#EB4646",
        footer:   "weather_notifications",
      }

      @slack.send_post post
    end
  end
end
