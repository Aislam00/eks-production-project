output "cert_manager_status" {
  value = helm_release.cert_manager.status
}

output "external_dns_status" {
  value = helm_release.external_dns.status
}

output "prometheus_status" {
  value = helm_release.prometheus.status
}

output "ingress_nginx_status" {
  value = helm_release.ingress_nginx.status
}
