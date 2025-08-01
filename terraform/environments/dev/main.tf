terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  enable_nat_gateway  = var.enable_nat_gateway
  common_tags         = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name        = "${var.project_name}-${var.environment}-cluster"
  cluster_version     = var.cluster_version
  
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  public_subnet_ids   = module.vpc.public_subnet_ids
  
  node_groups = {
    general = {
      instance_types = var.node_instance_types
      capacity_type  = "ON_DEMAND"
      disk_size     = var.node_disk_size
      scaling_config = {
        desired_size = var.node_desired_capacity
        max_size     = var.node_max_capacity
        min_size     = var.node_min_capacity
      }
    }
  }
  
  tags = local.common_tags

  depends_on = [module.vpc]
}