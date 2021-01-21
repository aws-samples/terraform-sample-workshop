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
    key     = "environments/providers/aws/prd/applications/nginx-sample-stack/main.tf"
    encrypt = true
  }
}

//Import the constants
module "environment" {
  source = "../../"
}

module "nginx_sample_stack" {
  source = "../../../../../../component_modules/nginx-webserver-stack"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
  user_data_path = "./user_data.sh"
}