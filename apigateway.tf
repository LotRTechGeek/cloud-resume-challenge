resource "aws_apigatewayv2_api" "counter" {

  name = "resume-counter-api"

  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda" {

  api_id = aws_apigatewayv2_api.counter.id

  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.visitor_counter.invoke_arn
}

resource "aws_apigatewayv2_route" "counter" {

  api_id = aws_apigatewayv2_api.counter.id

  route_key = "GET /count"

  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {

  api_id = aws_apigatewayv2_api.counter.id

  name = "$default"

  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway" {

  statement_id = "AllowExecutionFromAPIGateway"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.visitor_counter.function_name

  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.counter.execution_arn}/*/*"
}