# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

resource "aws_autoscaling_group" "default_asg" {
  count                     = var.associate_elb == "EC2" ? 1 : 0
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  launch_configuration      = var.lc_name
  vpc_zone_identifier       = var.subnets_id

  tags = [{
    key                 = "Name"
    value               = "${var.tag_name}"
    propagate_at_launch = true
    },
    {
      key                 = "Team"
      value               = "${var.tag_team}"
      propagate_at_launch = true
  }]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default_asg_elb" {
  count                     = var.associate_elb == "ELB" ? 1 : 0
  health_check_type         = var.health_check_type
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  desired_capacity          = var.desired_capacity
  launch_configuration      = var.lc_name
  vpc_zone_identifier       = var.subnets_id

  load_balancers = var.load_balancer

  tags = [{
    key                 = "Name"
    value               = "${var.tag_name}"
    propagate_at_launch = true
    },
    {
      key                 = "Team"
      value               = "${var.tag_team}"
      propagate_at_launch = true
    },
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default_asg_tg" {
  count                     = var.associate_elb == "TG" ? 1 : 0
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  launch_configuration      = var.lc_name
  vpc_zone_identifier       = var.subnets_id
  target_group_arns         = var.target_group_arns

  tags = [{
    key                 = "Name"
    value               = "${var.tag_name}"
    propagate_at_launch = true
  }]

  lifecycle {
    create_before_destroy = true
  }
}
