# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "lc_name" {}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "path_user_data" {}

variable "security_groups" {}

variable "iam_role" {}

variable "key_name" {}

variable "root_volume_size" {
  default = 30
}
