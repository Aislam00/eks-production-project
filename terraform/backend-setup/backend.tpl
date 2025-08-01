terraform {
  backend "s3" {
    bucket         = "${bucket_name}"
    key            = "dev/terraform.tfstate"
    region         = "${region}"
    dynamodb_table = "${dynamodb_table}"
    encrypt        = true
  }
}