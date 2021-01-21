# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "vpc_name" {
  default = "dev"
}

variable "cidr_vpc" {
  default = "172.16.0.0/16"
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
