# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

output "lc_name" {
  value = aws_launch_configuration.default_lc.name
}
