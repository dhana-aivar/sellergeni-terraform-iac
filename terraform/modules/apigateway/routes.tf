resource "aws_apigatewayv2_integration" "title_generator" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_functions["title_generator"]
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "title_generator" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /title"
  target    = "integrations/${aws_apigatewayv2_integration.title_generator.id}"
}

resource "aws_apigatewayv2_integration" "description_generator" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_functions["description_generator"]
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "description_generator" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "POST /description"
  target    = "integrations/${aws_apigatewayv2_integration.description_generator.id}"
}

resource "aws_lambda_permission" "title_generator" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_names["title_generator"]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

resource "aws_lambda_permission" "description_generator" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_names["description_generator"]
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
