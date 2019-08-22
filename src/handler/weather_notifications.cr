require "./../runtime/handler"
require "./../usecase/notify"
require "./../usecase/error"

def hello(event)
  begin
    app = Notify.new
    app.check_weather
  rescue err
    LambdaError.alert err
    raise err
  end
end

lambda_handler(hello)
