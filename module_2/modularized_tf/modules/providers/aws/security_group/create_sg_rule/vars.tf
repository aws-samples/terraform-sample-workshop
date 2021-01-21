# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "port" {}

variable "protocol" {
  default = "tcp"
}

variable "ips_sg_list" {
  type = list(string)
}

variable "security_group_id" {}
