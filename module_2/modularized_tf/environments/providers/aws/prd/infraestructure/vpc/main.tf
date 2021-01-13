provider "aws" {
  region = module.environment.aws_region
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = ""
    key     = "environments/providers/aws/prd/infraestructure/vpc/main.tf"
    encrypt = true
  }
}

module "default_vpc" {
    source = ""
}