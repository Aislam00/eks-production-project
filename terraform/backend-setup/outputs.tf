output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "terraform_state_dynamodb_table" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "aws_region" {
  value = var.aws_region
}