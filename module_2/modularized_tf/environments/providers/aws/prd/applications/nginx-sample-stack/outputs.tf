# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

output "elb_dns_name" {
  value = module.load_balancer.dns_name
}