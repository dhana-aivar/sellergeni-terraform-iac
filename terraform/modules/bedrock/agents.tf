# Bedrock Agents configuration
# Note: Bedrock Agents API may require specific resource types
# This is a placeholder structure - adjust based on actual AWS Bedrock Agents API

resource "aws_bedrock_agent" "title_generator" {
  agent_name         = "${var.environment}-title-generator-agent"
  agent_resource_role_arn = aws_iam_role.bedrock_agent.arn
  description        = "Agent for generating product titles"
  foundation_model   = "anthropic.claude-v2"
  
  instruction = <<-EOT
    You are an expert at generating compelling product titles based on product attributes.
    Generate titles that are SEO-friendly and appealing to customers.
  EOT

  tags = var.tags
}

resource "aws_bedrock_agent" "description_generator" {
  agent_name         = "${var.environment}-description-generator-agent"
  agent_resource_role_arn = aws_iam_role.bedrock_agent.arn
  description        = "Agent for generating product descriptions"
  foundation_model   = "anthropic.claude-v2"
  
  instruction = <<-EOT
    You are an expert at generating detailed product descriptions based on product attributes.
    Generate descriptions that are informative, engaging, and highlight key product features.
  EOT

  tags = var.tags
}
