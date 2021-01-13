data "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }
}