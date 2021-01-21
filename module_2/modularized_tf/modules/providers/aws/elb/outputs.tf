# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

output "elb_name" {
  value = aws_elb.default_elb.name
}

output "dns_name" {
  value = aws_elb.default_elb.dns_name
}
