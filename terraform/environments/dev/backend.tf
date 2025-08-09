terraform {
  backend "s3" {
    bucket         = "eks-production-demo-tfstate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "eks-production-demo-tfstate-locks"
    encrypt        = true
  }
}