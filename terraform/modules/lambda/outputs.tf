output "lambda_functions" {
  description = "Map of Lambda function names to their invoke ARNs"
  value = {
    title_generator      = aws_lambda_function.title_generator.invoke_arn
    description_generator = aws_lambda_function.description_generator.invoke_arn
  }
}

output "lambda_function_arns" {
  description = "Map of Lambda function names to their ARNs"
  value = {
    title_generator      = aws_lambda_function.title_generator.arn
    description_generator = aws_lambda_function.description_generator.arn
  }
}

output "lambda_function_names" {
  description = "Map of Lambda function names"
  value = {
    title_generator      = aws_lambda_function.title_generator.function_name
    description_generator = aws_lambda_function.description_generator.function_name
  }
}
