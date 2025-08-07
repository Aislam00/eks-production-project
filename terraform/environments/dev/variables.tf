variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.small"]
}

variable "node_desired_capacity" {
  type    = number
  default = 1
}

variable "node_max_capacity" {
  type    = number
  default = 3
}

variable "node_min_capacity" {
  type    = number
  default = 1
}

variable "node_disk_size" {
  type    = number
  default = 20
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "public_subnet_count" {
  type    = number
  default = 2
}

variable "private_subnet_count" {
  type    = number
  default = 2
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}