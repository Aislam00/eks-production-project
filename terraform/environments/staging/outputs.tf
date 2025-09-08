output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value     = module.eks.cluster_endpoint
  sensitive = true
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "oidc_issuer_url" {
  value = module.eks.oidc_issuer_url
}

output "ecr_repository_url" {
  value = aws_ecr_repository.pastefy_app.repository_url
}

output "route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "route53_nameservers" {
  value = aws_route53_zone.main.name_servers
}

output "external_dns_role_arn" {
  value = aws_iam_role.external_dns.arn
}
output "app_s3_role_arn" {
  value = aws_iam_role.app_s3_access.arn
}

output "cert_manager_role_arn" {
  value = aws_iam_role.cert_manager.arn
}

output "app_storage_bucket" {
  value = aws_s3_bucket.app_storage.bucket
}

output "helm_chart_status" {
  value = {
    cert_manager   = module.helm_charts.cert_manager_status
    external_dns   = module.helm_charts.external_dns_status
    prometheus     = module.helm_charts.prometheus_status
    ingress_nginx  = module.helm_charts.ingress_nginx_status
  }
}
