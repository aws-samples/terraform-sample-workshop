# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

resource "aws_elb" "default_elb" {
  name                        = var.elb_name
  subnets                     = var.subnets_ids
  security_groups             = ["${var.security_groups}"]
  internal                    = var.internal
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  listener {
    instance_port     = var.application_port
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 5
    timeout             = 3
    target              = var.healthcheck
    interval            = 30
  }
}
