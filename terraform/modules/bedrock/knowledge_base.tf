resource "aws_bedrock_knowledge_base" "main" {
  name     = "${var.environment}-product-knowledge-base"
  role_arn = aws_iam_role.bedrock_knowledge_base.arn

  knowledge_base_configuration {
    vector_knowledge_base_configuration {
      embedding_model_arn = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-embed-text-v1"
    }
  }

  storage_configuration {
    type = "OPENSEARCH_SERVERLESS"
    
    opensearch_serverless_configuration {
      collection_arn    = aws_opensearchserverless_collection.main.arn
      vector_index_name = "product-index"
      field_mapping {
        vector_field   = "vector"
        text_field     = "text"
        metadata_field = "metadata"
      }
    }
  }

  tags = var.tags
}

resource "aws_opensearchserverless_collection" "main" {
  name = "${var.environment}-bedrock-collection"
  type = "VECTORSEARCH"
}
