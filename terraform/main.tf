terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr = var.vpc_cidr
  environment = var.environment
  tags = var.tags
}

# KMS Module
module "kms" {
  source = "./modules/kms"
  
  environment = var.environment
  tags = var.tags
}

# S3 Module
module "s3" {
  source = "./modules/s3"
  
  environment = var.environment
  tags = var.tags
}

# Bedrock Module
module "bedrock" {
  source = "./modules/bedrock"
  
  environment = var.environment
  kms_key_id = module.kms.kms_key_id
  tags = var.tags
}

# Lambda Module
module "lambda" {
  source = "./modules/lambda"
  
  environment = var.environment
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  kms_key_id = module.kms.kms_key_id
  tags = var.tags
}

# API Gateway Module
module "apigateway" {
  source = "./modules/apigateway"
  
  environment = var.environment
  lambda_functions = module.lambda.lambda_functions
  lambda_function_names = module.lambda.lambda_function_names
  tags = var.tags
}
