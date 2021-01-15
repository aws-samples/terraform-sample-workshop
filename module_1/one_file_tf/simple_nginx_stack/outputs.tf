output "elb_dns_name" {
  value = aws_elb.nginx_lb.dns_name
}