# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

data "aws_availability_zones" "all" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc

  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.subnet_count
  cidr_block              = cidrsubnet(var.cidr_vpc, var.cidr_network_bits, count.index)
  availability_zone       = element(data.aws_availability_zones.all.names, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-${element(data.aws_availability_zones.all.names, count.index)}-subnet"
  }

  depends_on = [aws_vpc.vpc]
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = var.subnet_count
  cidr_block              = cidrsubnet(var.cidr_vpc, var.cidr_network_bits, (count.index + length(split(",", lookup(var.azs, var.region)))))
  availability_zone       = element(data.aws_availability_zones.all.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${element(data.aws_availability_zones.all.names, count.index)}-subnet"
  }

  depends_on = [aws_vpc.vpc]
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]
}

resource "aws_eip" "nat_gateway_eip" {
  count      = var.subnet_count
  vpc        = true
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = 2
  allocation_id = aws_eip.nat_gateway_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]
  depends_on    = [aws_internet_gateway.internet_gateway, aws_subnet.public_subnet]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route_table_public"
  }
}

resource "aws_route_table" "private" {
  count  = var.subnet_count
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }

  tags = {
    Name = "route_table_private"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(split(",", lookup(var.azs, var.region)))
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  count          = 2
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_route53_zone" "main_zone" {
  name = "${var.environment}.${var.zone_name}.internal"

  vpc {
    vpc_id = aws_vpc.vpc.id
  }
}

resource "aws_security_group" "vpc_security_group" {
  name   = "aws-${var.vpc_name}-vpc-sg"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "allow_ssh_internal" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.cidr_vpc]

  security_group_id = aws_security_group.vpc_security_group.id
}

resource "aws_security_group_rule" "egress_allow_all" {
  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "all"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.vpc_security_group.id
}
