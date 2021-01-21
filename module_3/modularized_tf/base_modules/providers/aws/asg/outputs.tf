# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

output "asg_name" {
  value = aws_autoscaling_group.default_asg.*.name
}
