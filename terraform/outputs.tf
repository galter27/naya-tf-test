################### VPC Outputs ###################

output "vpc_name" {
  description = "The name of the VPC"
  value       = var.vpc_name
}

output "vpc_cidr" {
  description = "The CIDR of the VPC"
  value = var.vpc_cidr
}

output "public_subnets" {
  description = "The list of public subnets in the VPC"
  value       = local.public_subnets
}

output "private_subnets" {
  description = "The list of private subnets in the VPC"
  value       = local.private_subnets
}

output "database_subnets" {
  description = "The list of database subnets in the VPC"
  value       = local.database_subnets
}