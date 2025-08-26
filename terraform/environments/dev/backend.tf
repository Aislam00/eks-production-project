terraform {
  backend "s3" {
    bucket         = "eks-production-demo-tfstate-475641479654-eu-west-2"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "eks-production-demo-tfstate-locks"
    encrypt        = true
    kms_key_id     = "alias/eks-production-demo-terraform-state"
  }
}