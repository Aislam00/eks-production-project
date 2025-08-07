output "iam_role_arn" {
  value = aws_iam_role.external_dns.arn
}

output "iam_role_name" {
  value = aws_iam_role.external_dns.name
}