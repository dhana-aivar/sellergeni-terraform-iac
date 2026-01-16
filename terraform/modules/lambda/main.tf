data "archive_file" "title_generator" {
  type        = "zip"
  source_dir  = "${path.module}/../../backend_code/title_generator"
  output_path = "${path.module}/title_generator.zip"
}

data "archive_file" "description_generator" {
  type        = "zip"
  source_dir  = "${path.module}/../../backend_code/description_generator"
  output_path = "${path.module}/description_generator.zip"
}

resource "aws_lambda_function" "title_generator" {
  filename         = data.archive_file.title_generator.output_path
  function_name    = "${var.environment}-title-generator"
  role            = aws_iam_role.lambda.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.11"
  timeout         = 30
  memory_size     = 256

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = var.tags
}

resource "aws_lambda_function" "description_generator" {
  filename         = data.archive_file.description_generator.output_path
  function_name    = "${var.environment}-description-generator"
  role            = aws_iam_role.lambda.arn
  handler         = "lambda_function.lambda_handler"
  runtime         = "python3.11"
  timeout         = 30
  memory_size     = 256

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }

  tags = var.tags
}
