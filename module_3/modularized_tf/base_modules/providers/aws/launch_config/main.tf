# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

resource "aws_launch_configuration" "default_lc" {
  name_prefix   = var.lc_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  user_data            = data.template_file.user_data.rendered
  security_groups      = ["${var.security_groups}"]
  iam_instance_profile = var.iam_role
  key_name             = var.key_name

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_volume_size
  }
}

data "template_file" "user_data" {
  template = file("${var.path_user_data}")
}
