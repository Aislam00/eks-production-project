output "terraform_state_bucket" {
  description = "Name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "terraform_state_dynamodb_table" {
  description = "Name of the DynamoDB table for Terraform state locks"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}