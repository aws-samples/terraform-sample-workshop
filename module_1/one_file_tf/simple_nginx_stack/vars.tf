variable "lc_name" {
  default = "lc-sample-nginx"
}

variable "vpc_id" {
  default = ""
}

variable "ami_id" {
  default = "ami-0be2609ba883822ec"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "ecs-demo-key"
}

variable "asg_name" {
  default = "sample-nginx-asg"
}

variable "lb_name" {
  default = "my-nginx-lb"
}

variable "public_subnets" {
  default = ["", ""]
}

variable "private_subnets" {
  default = ["", ""]
}

variable "sg_name" {
  default = "nginx-stack"
}