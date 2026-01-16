resource "aws_apigatewayv2_api" "main" {
  name          = "${var.environment}-sellergeni-api"
  protocol_type = "HTTP"
  description   = "API Gateway for SellerGeni application"

  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["*"]
  }

  tags = var.tags
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true

  tags = var.tags
}
