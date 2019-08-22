require "json"
require "../repository/slack"

module LambdaError
  extend self

  def alert(error)
    slack = Slack.new ENV["FAILD_WEBHOOK_URL"]

    post = {
      fallback: ENV["FAILD_FALLBACK"],
      pretext:  "<@#{ENV["SLACK_ID"]}> #{ENV["FAILD_FALLBACK"]}",
      title:    error.message,
      text:     error.backtrace.join("\n"),
      color:    "#EB4646",
      footer:   "weather_notifications",
    }

    slack.send_post post
  end
end
