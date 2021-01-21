# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

variable "sg_name" {
  default = "lc-nginx-module"
}

variable "ips_sg_list" {
  default = ["0.0.0.0/0"]
}

variable "elb_name" {
  default = "lb-nginx-tf-module"
}


variable "lc_name" {
  default = "lc-nginx-module"
}

variable "ami_id" {
  default = "ami-0be2609ba883822ec"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "role_name" {
  default = ""
}

variable "key_pair" {
  default = "nginx-demo-key"
}

variable "asg_name" {
  default = "nginx-module-asg"
}

variable "team" {
  default = "teste"
}

variable "ec2_port" {
  default = 80
}
