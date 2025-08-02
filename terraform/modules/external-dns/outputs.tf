output "iam_role_arn" {
  description = "ARN of the ExternalDNS IAM role"
  value       = aws_iam_role.external_dns.arn
}

output "iam_role_name" {
  description = "Name of the ExternalDNS IAM role"
  value       = aws_iam_role.external_dns.name
}