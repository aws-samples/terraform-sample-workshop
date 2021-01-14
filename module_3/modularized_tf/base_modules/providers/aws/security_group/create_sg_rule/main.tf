resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = var.port
  to_port     = var.port
  protocol    = var.protocol
  cidr_blocks = var.ips_sg_list

  security_group_id = var.security_group_id
}
