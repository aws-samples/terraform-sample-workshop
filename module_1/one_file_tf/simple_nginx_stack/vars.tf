# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

// VPC Variables

variable "vpc_name" {
  default = "production-vpc"
}

variable "cidr_vpc" {
  default = "10.5.0.0/16"
}

variable "cidr_network_bits" {
  default = "8"
}

variable "subnet_count" {
  default = "2"
}

variable "azs" {
  default = {
    "us-east-1" = "us-east-1a,us-east-1b,us-east-1c,us-east-1d"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "zone_name" {
  default = "client"
}

variable "environment" {
  default = "dev"
}

// Stack Variables

variable "lc_name" {
  default = "lc-sample-nginx"
}

variable "ami_id" {
  default = "ami-0be2609ba883822ec"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "nginx-demo-key"
}

variable "asg_name" {
  default = "sample-nginx-asg"
}

variable "lb_name" {
  default = "my-nginx-lb"
}

variable "sg_name" {
  default = "nginx-stack"
}