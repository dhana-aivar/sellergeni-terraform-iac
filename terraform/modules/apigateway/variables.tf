variable "environment" {
  description = "Environment name"
  type        = string
}

variable "lambda_functions" {
  description = "Map of Lambda function names to their invoke ARNs"
  type        = map(string)
}

variable "lambda_function_names" {
  description = "Map of Lambda function names"
  type        = map(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
