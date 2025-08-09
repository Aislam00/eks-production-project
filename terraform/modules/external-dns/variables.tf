variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  type        = string
}

variable "oidc_provider" {
  description = "OIDC provider URL without https://"
  type        = string
}

variable "domain_name" {
  description = "Domain name for external DNS"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}