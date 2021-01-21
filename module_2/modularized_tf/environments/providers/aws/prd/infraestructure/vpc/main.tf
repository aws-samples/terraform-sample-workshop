# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

provider "aws" {
  region = module.environment.aws_region
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "<YOUR BUCKET NAME GOES HERE>"
    key     = "environments/providers/aws/prd/infraestructure/vpc/main.tf"
    encrypt = true
  }
}

//Import the constants
module "environment" {
  source = "../../"
}

module "default_vpc" {
  source      = "../../../../../../modules/providers/aws/vpc"
  vpc_name    = var.vpc_name
  cidr_vpc    = var.cidr_vpc
  environment = "prd"
}