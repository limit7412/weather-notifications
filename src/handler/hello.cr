require "./../runtime/handler"
require "./../usecase/error"

def hello(event)
  begin
    event["body"]
  rescue err
    LambdaError.alert err
    raise err
  end
end

lambda_handler(hello)
