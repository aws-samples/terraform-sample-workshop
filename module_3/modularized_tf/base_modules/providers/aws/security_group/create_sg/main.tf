resource "aws_security_group" "default" {
  name        = "${var.sg_name}-sg"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
