output "agent_arns" {
  description = "ARNs of Bedrock agents"
  value = {
    title_generator      = try(aws_bedrock_agent.title_generator.arn, null)
    description_generator = try(aws_bedrock_agent.description_generator.arn, null)
  }
}

output "knowledge_base_id" {
  description = "ID of the Bedrock knowledge base"
  value       = try(aws_bedrock_knowledge_base.main.id, null)
}
