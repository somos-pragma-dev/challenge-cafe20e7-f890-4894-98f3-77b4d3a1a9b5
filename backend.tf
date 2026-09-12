terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state-${var.environment}"
    key            = "notifications-service/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project_name}-terraform-lock-${var.environment}"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${var.environment}"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = var.environment
    Purpose     = "State Management"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = "${var.project_name}-terraform-lock-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform Lock Table"
    Environment = var.environment
    Purpose     = "State Locking"
    ManagedBy   = "Terraform"
  }
}

resource "aws_dynamodb_table_server_side_encryption" "terraform_lock" {
  count        = var.environment != "dev" ? 1 : 0
  table_name   = aws_dynamodb_table.terraform_lock.name
  server_side_encryption = "ENABLED"
  kms_key_arn  = var.kms_key_arn
}

output "terraform_state_bucket" {
  description = "Nombre del bucket S3 para estado de Terraform"
  value       = aws_s3_bucket.terraform_state.id
}

output "terraform_lock_table" {
  description = "Nombre de la tabla DynamoDB para locking de Terraform"
  value       = aws_dynamodb_table.terraform_lock.name
}