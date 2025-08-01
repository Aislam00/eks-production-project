variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "eks-production-demo"
}