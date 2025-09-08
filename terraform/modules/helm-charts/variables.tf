variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_data" {
  type = string
}

variable "external_dns_role_arn" {
  type = string
}

variable "cert_manager_role_arn" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "cluster_ready" {
  type = string
}
