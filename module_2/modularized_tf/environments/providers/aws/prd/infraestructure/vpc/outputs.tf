output "vpc_id" {
  value = module.default_vpc.vpc_id
}

output "public_subnets" {
  value = module.default_vpc.public_subnets
}

output "private_subnets" {
  value = module.default_vpc.public_subnets
}