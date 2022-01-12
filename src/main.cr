require "./runtime/handler"
require "./usecase/notify"
require "./usecase/error"

Serverless::Lambda.handler "weather_notifications" do |_|
  begin
    app = Usecase::Notify.new
    app.check_weather
  rescue err
    alert = Usecase::Alert.new err
    alert.send
    raise err
  end
end
