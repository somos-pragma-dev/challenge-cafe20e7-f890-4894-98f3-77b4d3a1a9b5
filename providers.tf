terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "notificaciones-servicio"
      ManagedBy   = "Terraform"
      Owner       = "cloudops-team"
    }
  }

  iam = {
    max_session_duration = 43200
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = false
}

// Proveedor para recursos de terceros que requieren acceso a AWS
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      Environment = var.environment
      Project     = "notificaciones-servicio"
      ManagedBy   = "Terraform"
      Owner       = "cloudops-team"
    }
  }
}

// Configuración de endpoints para comunicación privada con servicios AWS
provider "aws" {
  alias  = "private_endpoints"
  region = var.aws_region

  endpoints {
    sns        = "https://sns.${var.aws_region}.amazonaws.com"
    sqs        = "https://sqs.${var.aws_region}.amazonaws.com"
    lambda     = "https://lambda.${var.aws_region}.amazonaws.com"
    cloudwatch = "https://monitoring.${var.aws_region}.amazonaws.com"
    logs       = "https://logs.${var.aws_region}.amazonaws.com"
    kms        = "https://kms.${var.aws_region}.amazonaws.com"
  }
}