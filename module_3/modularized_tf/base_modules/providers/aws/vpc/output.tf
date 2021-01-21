# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "zone_id" {
  value = aws_route53_zone.main_zone.zone_id
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.private_subnet.*.id
}

output "vpc_security_group" {
  value = aws_security_group.vpc_security_group.id
}

output "route_table_public" {
  value = aws_route_table.public.id
}

output "route_table_private" {
  value = aws_route_table.private.*.id
}

output "nat_gateway_eip" {
  value = "[${join(",", aws_subnet.public_subnet.*.id)}]"
}
