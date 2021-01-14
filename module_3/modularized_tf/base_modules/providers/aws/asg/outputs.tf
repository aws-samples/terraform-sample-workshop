output "asg_name" {
  value = aws_autoscaling_group.default_asg.*.name
}
