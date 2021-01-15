provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "terraform-state-workshoptest"
    key     = "terraform/one_file_tf/simple_nginx_stack/main.tf"
    encrypt = true
  }
}

// One Line terraform to provision ELB + EC2 in ASG with LC and Nginx

resource "aws_security_group" "lc_sg" {
  name        = "${var.sg_name}-lc"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_internal_vpc" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "TCP"
  cidr_blocks = ["10.10.0.0/16"]

  security_group_id = aws_security_group.lc_sg.id
}

resource "aws_launch_configuration" "my_sample_lc" {
  name_prefix     = "${var.lc_name}-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  user_data       = file("files/install_nginx.sh")
  key_name        = var.key_name
  security_groups = [aws_security_group.lc_sg.id]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "my_sample_asg" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.my_sample_lc.name // Reference form above
  min_size             = 2
  desired_capacity     = 2
  max_size             = 4
  vpc_zone_identifier  = var.private_subnets
  health_check_type    = "ELB"
  load_balancers       = [aws_elb.nginx_lb.name] // Add instances below Classic LB

  tag {
    key                 = "Name"
    value               = "asg-nginx-test"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

// LB security Group

resource "aws_security_group" "lb_sg" {
  name        = "${var.sg_name}-lb"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.lb_sg.id
}

// Classic LoadBalancer for application

resource "aws_elb" "nginx_lb" {
  name                        = var.lb_name
  subnets                     = var.public_subnets
  security_groups             = [aws_security_group.lb_sg.id]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  internal                    = false

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 30
  }


}