# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "elb_name" {}

variable "subnets_ids" {
  default = []
}

variable "application_port" {}

variable "security_groups" {
  default = []
}

variable "internal" {
  default = false
}

variable "idle_timeout" {
  default = 400
}

variable "connection_draining" {
  default = false
}

variable "connection_draining_timeout" {
  default = 300
}

variable "healthcheck" {
  default = "TCP:80"
}