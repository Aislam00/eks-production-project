variable "cluster_name" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}