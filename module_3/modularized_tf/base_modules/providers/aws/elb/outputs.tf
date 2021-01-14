output "elb_name" {
  value = aws_elb.default_elb.name
}

output "dns_name" {
  value = aws_elb.default_elb.dns_name
}
