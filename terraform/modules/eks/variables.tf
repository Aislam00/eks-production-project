variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "node_groups" {
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    disk_size      = number
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}