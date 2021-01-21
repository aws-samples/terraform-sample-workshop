# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# SPDX-License-Identifier: MIT-0

module "aws_security_group_lb" {
  source  = "../../base_modules/providers/aws/security_group/create_sg"
  sg_name = var.sg_name
  vpc_id  = var.vpc_id
}

module "sg_rules_https" {
  source            = "../../base_modules/providers/aws/security_group/create_sg_rule"
  port              = 80
  protocol          = "TCP"
  ips_sg_list       = var.ips_sg_list
  security_group_id = module.aws_security_group_lb.id
}

module "load_balancer" {
  source           = "../../base_modules/providers/aws/elb"
  elb_name         = var.elb_name
  subnets_ids      = var.public_subnets
  security_groups  = module.aws_security_group_lb.id
  application_port = 80
}

module "aws_launch_configuration" {
  source          = "../../base_modules/providers/aws/launch_config"
  lc_name         = var.lc_name
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  path_user_data  = var.user_data_path
  security_groups = module.security_group.id
  iam_role        = var.role_name
  key_name        = var.key_pair
}

module "aws_autoscaling_group" {
  source            = "../../base_modules/providers/aws/asg"
  asg_name          = var.asg_name
  associate_elb     = "ELB"
  load_balancer     = [module.load_balancer.elb_name]
  health_check_type = "ELB"
  lc_name           = module.aws_launch_configuration.lc_name
  subnets_id        = var.private_subnets
  tag_name          = var.asg_name
  tag_team          = var.team
}


module "security_group" {
  source  = "../../base_modules/providers/aws/security_group/create_sg"
  sg_name = "wordpress-poc-sg"
  vpc_id  = var.vpc_id
}

module "add_sg_rule" {
  source            = "../../base_modules/providers/aws/security_group/create_sg_rule"
  port              = var.ec2_port
  ips_sg_list       = ["10.5.0.0/16"]
  security_group_id = module.security_group.id
}
