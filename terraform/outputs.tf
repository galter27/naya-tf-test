#---------------------------------------------------------------
# VPC Outputs
#---------------------------------------------------------------

output "public_subnet_cidrs" {
  description = "The CIDR blocks of the public subnets"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_cidrs" {
  description = "The CIDR blocks of the private subnets"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "database_subnet_cidrs" {
  description = "The CIDR blocks of the database subnets"
  value       = module.vpc.database_subnets_cidr_blocks
}

output "public_subnet_names" {
  description = "The names of the public subnets"
  value       = [for idx, subnet in module.vpc.public_subnets : "${var.vpc_name}-public-${idx + 1}"]
}

output "private_subnet_names" {
  description = "The names of the private subnets"
  value       = [for idx, subnet in module.vpc.private_subnets : "${var.vpc_name}-private-${idx + 1}"]
}

output "database_subnet_names" {
  description = "The names of the database subnets"
  value       = [for idx, subnet in module.vpc.database_subnets : "${var.vpc_name}-database-${idx + 1}"]
}

output "internet_gateway_name" {
  description = "The name of the Internet Gateway"
  value       = module.vpc.igw_id != null ? "${var.vpc_name}-internet-gateway" : "None"
}

#---------------------------------------------------------------
# Security Groups Outputs
#---------------------------------------------------------------

output "bastion_sg_name" {
  description = "The name of the Bastion Security Group"
  value       = module.bastion_sg.security_group_name
}

output "private_sg_name" {
  description = "The name of the Private Security Group"
  value       = module.private_sg.security_group_name
}

output "database_sg_name" {
  description = "The name of the Database Security Group"
  value       = module.database_sg.security_group_name
}

#---------------------------------------------------------------
# Compute Resources Outputs
#---------------------------------------------------------------

output "bastion_ec2_private_ip" {
  description = "The name of the Bastion EC2 instance"
  value       = module.bastion_ec2.private_ip
}

output "bastion_ec2_public_ip" {
  description = "The name of the Bastion EC2 instance"
  value       = module.bastion_ec2.public_ip
}

output "postgres_client_private_ip" {
  description = "The name of the Postgres Client EC2 instance"
  value       = module.postgres_client_ec2.private_ip
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = module.lambda_function.lambda_function_name
}

#---------------------------------------------------------------
# DB Resources Outputs
#---------------------------------------------------------------

output "rds_db_instance_name" {
  description = "The name of the RDS isntance name"
  value       = module.rds_postgres.db_instance_name
}