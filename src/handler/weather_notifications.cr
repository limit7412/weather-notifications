require "./../runtime/handler"
require "./../usecase/notify"
require "./../usecase/error"

def hello(event)
  begin
    app = NotifyUsecase.new
    app.check_weather
  rescue err
    ErrorUsecase.alert err
    raise err
  end
end

lambda_handler(hello)
