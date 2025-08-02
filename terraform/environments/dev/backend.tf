terraform {
  backend "s3" {
    bucket = "eks-production-demo-tfstate-agqxchyw"
    key    = "dev/terraform.tfstate"
    region = "eu-west-2"
  }
}
