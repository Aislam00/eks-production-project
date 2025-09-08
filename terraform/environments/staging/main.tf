terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  enable_nat_gateway   = var.enable_nat_gateway
  
  common_tags = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "${var.project_name}-${var.environment}-cluster"
  cluster_version    = var.cluster_version
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  tags               = local.common_tags

  node_groups = {
    general = {
      instance_types = var.node_instance_types
      capacity_type  = "ON_DEMAND"
      disk_size      = var.node_disk_size
      scaling_config = {
        desired_size = var.node_desired_capacity
        max_size     = var.node_max_capacity
        min_size     = var.node_min_capacity
      }
    }
  }
}

resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = local.common_tags
}

resource "aws_kms_key" "ecr" {
  description             = "KMS key for ECR encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = true
  tags                    = local.common_tags
}

resource "aws_ecr_repository" "pastefy_app" {
  name                 = "pastefy-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key        = aws_kms_key.ecr.arn
  }

  tags = local.common_tags
}

resource "aws_ecr_lifecycle_policy" "pastefy_app" {
  repository = aws_ecr_repository.pastefy_app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v"]
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
module "helm_charts" {
  source = "../../modules/helm-charts"
  
  cluster_name           = module.eks.cluster_name
  cluster_endpoint       = module.eks.cluster_endpoint
  cluster_ca_data        = module.eks.cluster_certificate_authority_data
  external_dns_role_arn  = aws_iam_role.external_dns.arn
  cert_manager_role_arn  = aws_iam_role.cert_manager.arn
  domain_name            = var.domain_name
  aws_region             = var.aws_region
  cluster_ready          = module.eks.cluster_name
}
