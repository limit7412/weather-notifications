require "./../runtime/handler"
require "./../usecase/notify"
require "./../usecase/error"

Lambda.handler do |event|
  begin
    app = Notify.new
    app.check_weather
  rescue err
    LambdaError.alert err
    raise err
  end
end
