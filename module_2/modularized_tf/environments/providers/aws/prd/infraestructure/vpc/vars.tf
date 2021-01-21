# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "vpc_name" {
  default = "production-vpc"
}

variable "cidr_vpc" {
  default = "10.5.0.0/16"
}